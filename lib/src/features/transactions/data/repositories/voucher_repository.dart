import 'dart:convert';

import 'package:facilapp/src/features/transactions/models/voucher.dart';
import 'package:http/http.dart' as http;

const URL_BASE =
    "http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/registros";

class VoucherRepository {
  Future<List<dynamic>> getAllVoucher(
      {String registros, int offset, int limit, String query}) async {
    var url = URL_BASE +
        '?sort=registro.desc&offset=$offset&limit=$limit${registros != null ? '&registro=$registros' : ''}${query != null ? '&search=$query':''}';
    var response = await http.get(url);
    Map<String, dynamic> responseData = json.decode(response.body);
    List voucherJson = responseData["data"].toList();
    int total = responseData["total"];
    List<Voucher> vouchers =
        voucherJson.map((voucherJson) => Voucher.fromMap(voucherJson)).toList();
    List list = [
      vouchers,
      total
    ];
    return list;
  }
}
