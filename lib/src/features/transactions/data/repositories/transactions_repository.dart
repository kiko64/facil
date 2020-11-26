import 'dart:convert';
import 'dart:core';

import 'package:facilapp/src/features/transactions/models/activity.dart';
import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:facilapp/src/config/globals.dart' as globals;
import 'package:http/http.dart' as http;

const URL_BASE =
    "http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/ejecutar";

class TransactionRepository {
  Future<List<dynamic>> getAllTransactions(
      {final name, int limit, int offset}) async {
    var status= globals.selected;
    print(globals.selected);
    var url = URL_BASE + '${status != 12600 ? '?seguimiento=$status&': '?'}offset=$offset&limit=$limit';
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

  Future cancelTransaction(final id, final status) async {
    var url = URL_BASE + '/$id';

    Map<String, String> headers = {'Content-Type': 'application/json'};
    var body = json.encode({"seguimiento": status});
    var response = await http.patch(url, body: body, headers: headers);
    return response.statusCode;
  }

  Future updateTransaction(
      final id,
      final idActivity,
      final value,
      final docAuxiliary,
      final account,
      final observation,
      final images) async {
    var url = URL_BASE + '/$id';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "agenda": idActivity,
      "valor": value,
      "documento": docAuxiliary,
      "cuenta": account,
      "observacion": observation,
      "archivo0": images[0],
      "archivo1": images[1],
      "archivo2": images[2],
      "archivo3": images[3]
    });
    var response = await http.patch(url, body: body, headers: headers);
    return response.statusCode;
  }

  Future registerTransaction() async {}

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
}
