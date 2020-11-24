import 'dart:convert';

import 'package:facilapp/src/features/transactions/models/voucher.dart';
import 'package:http/http.dart' as http;

const URL_BASE =
    "http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/registros";

class VoucherRepository {
  Future<List<Voucher>> getAllVoucher(
      {String registros, int offset, int limit}) async {
    var url = URL_BASE +
        '?offset=$offset&limit=$limit${registros != null ? '&registro=$registros' : ''}';
    var response = await http.get(url);
    Map<String, dynamic> responseData = json.decode(response.body);
    List voucherJson = responseData["data"].toList();
    List<Voucher> vouchers =
        voucherJson.map((voucherJson) => Voucher.fromMap(voucherJson)).toList();
    return vouchers;
  }
}
