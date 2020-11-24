import 'dart:convert';

import 'package:facilapp/src/features/transactions/models/movement.dart';
import 'package:http/http.dart' as http;

const URL_BASE =
    "http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/movimientos";

class MovementsRepository {
  Future<List<Movement>> getByVoucher(
      {int id}) async {
    var url = URL_BASE + '?registro=$id';
    var response = await http.get(url);
    Map<String, dynamic> responseData = json.decode(response.body);
    List movementJson = responseData["data"].toList();
    List<Movement> movements = movementJson
        .map((movementJson) => Movement.fromMap(movementJson))
        .toList();
    return movements;
  }
}
