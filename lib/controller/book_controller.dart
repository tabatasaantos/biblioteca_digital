import 'package:biblioteca_digital/database/book_database.dart';
import 'package:biblioteca_digital/models/google_book_model.dart';
import 'package:biblioteca_digital/models/personal_book_model.dart';

class BookController {
  PersonalBookDatabase personalBookDatabase = PersonalBookDatabase();

  void addBook(GoogleBooksModel googleBookModel, String dayStarted,
      String dayFinished, String comments) {
    PersonalBookModel newBook = PersonalBookModel(
        dayStarted: dayStarted,
        dayFinished: dayFinished,
        comments: comments,
        googleBook: googleBookModel);

    personalBookDatabase.save(newBook);
  }

  Future<List<PersonalBookModel>> getBooks() {
    return personalBookDatabase.findAll();
  }

  void updateBook(PersonalBookModel personalBook) {
    personalBookDatabase.save(personalBook);
  }

  void deleteBook(PersonalBookModel personalBook) {
    personalBookDatabase.delete(personalBook);
  }
}
