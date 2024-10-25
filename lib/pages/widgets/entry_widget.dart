import 'package:biblioteca_digital/models/google_book_model.dart';
import 'package:biblioteca_digital/until/theme_until.dart';
import 'package:flutter/material.dart';

class Entry extends StatelessWidget {
  Entry({super.key, required this.googleBooksModel});

  GoogleBooksModel googleBooksModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.network(
              googleBooksModel.thumbnailLink,
              height: 126,
              width: 86,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    googleBooksModel.title,
                    style: EntryDecorationProperties.displayText,
                  ),
                ),
                Text(
                  googleBooksModel.authors,
                  style: EntryDecorationProperties.authorText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
