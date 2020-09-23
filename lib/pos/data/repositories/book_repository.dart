import 'dart:convert';
import 'dart:io';
import 'package:facilapp/pos/models/book.dart';
import 'package:http/http.dart' as http;

const URL_BASE =
    "http://multimodulolibrerias-env.eba-mfxm2vgp.us-west-2.elasticbeanstalk.com/api/v1/book";

class BookRepository {
  Future<List<Book>> getAllBook({final name}) async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var url = URL_BASE;
    var response = await http.get(url, headers: headers);
    Map<String, dynamic> responseData = json.decode(response.body);
    List bookJson = responseData["data"].toList();
    List<Book> books =
        bookJson.map((bookJson) => Book.fromMap(bookJson)).toList();
    return books;
  }

  Future registerBook(
      {final name,
      final numberOfPages,
      final price,
      final publicationDate,
      final status}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var body = json.encode({
      "name": name,
      "numberOfPages": numberOfPages,
      "price": price,
      "publicationDate": publicationDate,
      "status": status
    });

    var response = await http.post(URL_BASE, body: body, headers: headers);
    return response.statusCode;
  }

  Future updateBook(
      {final id,
      final name,
      final numberOfPages,
      final price,
      final publicationDate,
      final status}) async {
    var url = URL_BASE + '/$id';

    Map<String, String> headers = {'Content-Type': 'application/json'};

    var body = json.encode({
      "name": name,
      "numberOfPages": numberOfPages,
      "price": price,
      "publicationDate": publicationDate,
      "status": status
    });

    var response = await http.patch(url, body: body, headers: headers);
    return response.statusCode;
  }

  Future deleteBook({final id}) async {
    var url = URL_BASE + '/$id';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await http.delete(url, headers: headers);
    return response.statusCode;
  }
}
