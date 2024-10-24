import 'dart:convert';

import 'package:biblioteca_digital/models/google_book_model.dart';

class PersonalBookModel {
  int? id;
  String dayStarted;
  String dayFinished;
  String comments;
  GoogleBooksModel googleBook;

  PersonalBookModel(
      {required this.dayStarted,
      required this.dayFinished,
      required this.comments,
      required this.googleBook,
      this.id});

  PersonalBookModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        dayStarted = map["dayStarted"],
        dayFinished = map["dayFinished"],
        comments = map["comments"],
        googleBook = GoogleBooksModel.fromJson(json.decode(map["googleBook"]));

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "googleBook": json.encode(googleBook.toMap()),
      "dayStarted": dayStarted,
      "dayFinished": dayFinished,
      "comments": comments
    };
  }
}
