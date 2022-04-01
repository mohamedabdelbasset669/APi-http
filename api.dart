import 'dart:convert';
import 'package:flutter_application_3/author.dart';
import 'package:http/http.dart';

class API {
  static const String _BASE_URL = 'http://10.0.2.2:8888';
  static Future<Author> createAuthor(Author author) async {
    final Response response = await post('$_BASE_URL/authors',
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(author.toJson()));

    if (response.statusCode == 200) {
      return Author.fromJson(json.decode(response.body));
    } else {
      throw Exception("Can't load author");
    }
  }

  static Future<List<Author>> getAllAuthors() async {
    final Response response = await get('$_BASE_URL/authors');

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Author>((item) => Author.fromJson(item)).toList();
    } else {
      throw Exception("Can't load author");
    }
  }
}
