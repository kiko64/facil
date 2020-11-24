
import 'dart:convert';
import 'dart:core';

import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:http/http.dart' as http;

const URL_BASE =
    "http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/ejecutar";

class TransactionRepository {
  Future<List<dynamic>> getAllTransactions(
      {final name, int limit, int offset}) async {
    var url = URL_BASE + '?offset=$offset&limit=$limit';
    var response = await http.get(url);
    Map<String, dynamic> responseData = json.decode(response.body);
    List transactionJson = responseData["data"].toList();
    int total = responseData["total"];
    // int total = responseData["total"];
    List<Transaction> transactions = transactionJson
        .map((transactionJson) => Transaction.fromMap(transactionJson))
        .toList();
    List list = [
      transactions,
      total
    ];
    return list;
  }

  Future cancelTransaction(final id, final status) async {
    var url = URL_BASE + '/$id';

    Map<String, String> headers = {'Content-Type': 'application/json'};
    var body = json.encode({"seguimiento": status});
    var response = await http.patch(url, body: body, headers: headers);
    return response.statusCode;
  }
}
