import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facilapp/src/features/transactions/models/account.dart';
import 'package:facilapp/src/features/transactions/models/activity.dart';
import 'package:facilapp/src/features/transactions/models/auxiliary.dart';
import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:facilapp/src/config/globals.dart' as globals;
import 'package:http/http.dart' as http;

const URL_BASE =
    "http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/ejecutar";

class TransactionRepository {
  Future<List<dynamic>> getAllTransactions(
      {final name, int limit, int offset}) async {
    var status = globals.selected;
    var url = URL_BASE +
        '${status != 12600 ? '?seguimiento=$status&' : '?'}offset=$offset&limit=$limit&sort=ejecutar.desc';
    var response = await http.get(url);
    Map<String, dynamic> responseData = json.decode(response.body);
    List transactionJson = responseData["data"].toList();
    int total = responseData["total"];
    // int total = responseData["total"];
    List<Transaction> transactions = transactionJson
        .map((transactionJson) => Transaction.fromMap(transactionJson))
        .toList();
    List list = [transactions, total];
    return list;
  }

  Future cancelTransaction({final id, final status}) async {
    var url = URL_BASE + '/$id';

    Map<String, String> headers = {'Content-Type': 'application/json'};
    var body = json.encode({"seguimiento": status});
    var response = await http.patch(url, body: body, headers: headers);
    return response.statusCode;
  }

  Future updateTransaction(
      {final id,
      final idActivity,
      final value,
      final docAuxiliary,
      final account,
      final observation,
      final images}) async {
    var url = URL_BASE + '/$id';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "agenda": idActivity,
      "valor": value,
      "documento": docAuxiliary,
      "cuenta": account,
      "observacion": observation,
    });
    var response = await http.patch(url, body: body, headers: headers);
    return response.statusCode;
  }

  Future registerTransaction({
    final date,
    final tracing,
    final activity,
    final document,
    final account,
    final value,
    final observation,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "fecha": date,
      "seguimiento": tracing,
      "agenda": activity,
      "documento": document,
      "cuenta": account,
      "mascara": 0,
      "usuario": "Ocobo",
      "valor": value,
      "observacion": observation,
      "registro": " ",
    });
    var response = await http.post(URL_BASE, body: body, headers: headers);
    return response;
  }

  Future updateImages({String id, List images}) async {
    Dio dio = new Dio();
    final int length = images.length;
    // dio.options.headers["Content-Type"] = "multipart/form-data";
    // dio.options.headers["authorization"] = await LocalStorage().obtenerToken();
    FormData formData;
    switch (length) {
      case 1:
        formData = FormData.fromMap({
          "file0": await MultipartFile.fromFile(
            images[0].path,
          ),
        });
        break;
      case 2:
        formData = FormData.fromMap({
          "file0": await MultipartFile.fromFile(
            images[0].path,
          ),
          "file1": await MultipartFile.fromFile(
            images[1].path,
          ),
        });
        break;
      case 3:
        formData = FormData.fromMap({
          "file0": await MultipartFile.fromFile(
            images[0].path,
          ),
          "file1": await MultipartFile.fromFile(
            images[1].path,
          ),
          "file2": await MultipartFile.fromFile(
            images[2].path,
          ),
        });
        break;
      case 4:
        formData = FormData.fromMap({
          "file0": await MultipartFile.fromFile(
            images[0].path,
          ),
          "file1": await MultipartFile.fromFile(
            images[1].path,
          ),
          "file2": await MultipartFile.fromFile(
            images[2].path,
          ),
          "file3": await MultipartFile.fromFile(
            images[3].path,
          ),
        });
        break;
      default:
    }

    var response = await dio.patch(
        'http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/ejecutar/uploadFiles/$id',
        data: formData);
    print(response.statusCode);
    return response.statusCode;
  }

  Future<List<Activity>> getActivities({final number, final word}) async {
    var url =
        'http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/gparametros/consulta$number/$word';
    var response = await http.get(url);
    List activityJson = json.decode(response.body).toList();
    // List activityJson = responseData["data"].toList();
    List<Activity> activities = activityJson
        .map((transactionJson) => Activity.fromMap(transactionJson))
        .toList();
    return activities;
  }

  Future<List<Account>> getAccounts() async {
    var url =
        'http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/cuentas?fields=cuenta,desCuenta,tipo&sort=cuenta.desc';
    var response = await http.get(url);
    Map<String, dynamic> responseData = json.decode(response.body);
    List accountJson = responseData["data"].toList();
    List<Account> accounts =
        accountJson.map((accountJson) => Account.fromMap(accountJson)).toList();
    return accounts;
  }

  Future<List<Auxiliary>> getAuxiliaries({final number, final type}) async {
    var url =
        'http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/auxiliares/consulta$number?search=oco&tipos=$type';
    var response = await http.get(url);
    List auxiliaryJson = json.decode(response.body).toList();
    List<Auxiliary> auxiliaries = auxiliaryJson
        .map((auxiliaryJson) => Auxiliary.fromMap(auxiliaryJson))
        .toList();
    return auxiliaries;
  }
}
