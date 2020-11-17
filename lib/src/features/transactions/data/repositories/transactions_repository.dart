
import 'dart:convert';

import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:http/http.dart' as http;

const URL_BASE =
    "http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/ejecutar";

class TransactionRepository {
  Future<List<Transaction>> getAllBook({final name}) async {
    var url = URL_BASE;
    var response = await http.get(url);
    Map<String, dynamic> responseData = json.decode(response.body);
    List transactionJson = responseData["data"].toList();
    List<Transaction> transactions =
        transactionJson.map((transactionJson) => Transaction.fromMap(transactionJson)).toList();
    return transactions;
  }
}