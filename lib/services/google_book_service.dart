import 'dart:convert';

import 'package:biblioteca_digital/models/google_book_model.dart';
import 'package:http/http.dart' as http;

class GoogleBooksService {
  static const String baseUrl = "https://www.googleapis.com/books/v1/volumes";

  Future<List<GoogleBooksModel>> searchBooks(String name) async {
    if (name != "") {
      http.Response httpResponse =
          await http.get(Uri.parse("$baseUrl/?q=$name"));

      Map<String, dynamic> response = json.decode(httpResponse.body);
      List listResponse = response["items"];

      List<GoogleBooksModel> listResult = [];
      for (int i = 0; i < listResponse.length; i++) {
        listResult.add(GoogleBooksModel.fromApi(listResponse[i]));
      }

      return listResult;
    }
    return List.empty();
  }
}
