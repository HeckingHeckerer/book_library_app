// This class represents a single book entity in the application.
// It only contains data and does not handle UI or logic.
// In MVVM, the Model is responsible for holding structured data.

class BookModel {
  String title;
  String author;
  int yearPublished;
  bool isRead;

  // Constructor used to initialize a book object
  BookModel({
    required this.title,
    required this.author,
    required this.yearPublished,
    required this.isRead,
  });
}
