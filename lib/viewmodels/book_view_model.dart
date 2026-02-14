import 'package:flutter/material.dart';
import '../models/book_model.dart';

// The ViewModel manages the business logic of the app.
// It connects the UI (View) with the data (Model).
// ChangeNotifier allows the UI to automatically rebuild
// whenever the book list changes.

class BookViewModel extends ChangeNotifier {

  // Private list to protect direct modification from outside
  final List<BookModel> _books = [];

  // Public getter to allow UI access but prevent direct editing
  List<BookModel> get books => _books;

  // Adds a new book to the list
  void addBook(BookModel book) {
    _books.add(book);
    notifyListeners(); // Notify UI that data has changed
  }

  // Updates an existing book at a specific index
  void updateBook(int index, BookModel updatedBook) {
    _books[index] = updatedBook;
    notifyListeners();
  }

  // Deletes a book using its index
  void deleteBook(int index) {
    _books.removeAt(index);
    notifyListeners();
  }
}
