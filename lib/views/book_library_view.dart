import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/book_view_model.dart';
import '../models/book_model.dart';

// This screen displays the list of books.
// It listens to changes from BookViewModel.

class BookLibraryView extends StatelessWidget {
  const BookLibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookVM = Provider.of<BookViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Book Library")),

      // Floating button for adding new books
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBookDialog(context),
        icon: const Icon(Icons.add),
        label: const Text("Add a Book"),
        backgroundColor: Colors.white, // optional: matches your theme
        foregroundColor: Colors.black, // optional: text/icon color
      ),

      body: ListView.builder(
        itemCount: bookVM.books.length,
        itemBuilder: (context, index) {
          final book = bookVM.books[index];

          return Card(
            child: ListTile(
              title: Text(
                book.title,
                style: TextStyle(
                  decoration: book.isRead ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(
                "${book.author} (${book.yearPublished})",
                style: const TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
              ),

              // Read/Unread indicator
              leading: Icon(
                book.isRead ? Icons.check_circle : Icons.menu_book,
                color: book.isRead ? Colors.green : Colors.red,
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit Button
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        _showBookDialog(context, index: index, book: book),
                  ),

                  // Delete Button
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      final deletedBookTitle = book.title;
                      bookVM.deleteBook(index);

                      // Show SnackBar confirming deletion
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleted "$deletedBookTitle"'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Dialog for adding or editing a book
  void _showBookDialog(BuildContext context, {int? index, BookModel? book}) {
    final titleController = TextEditingController(text: book?.title ?? "");
    final authorController = TextEditingController(text: book?.author ?? "");
    final yearController = TextEditingController(
      text: book?.yearPublished.toString() ?? "",
    );
    bool isRead = book?.isRead ?? false;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(index == null ? "Add Book" : "Edit Book"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: "Title"),
                    ),
                    TextField(
                      controller: authorController,
                      decoration: const InputDecoration(labelText: "Author"),
                    ),
                    TextField(
                      controller: yearController,
                      decoration: const InputDecoration(
                        labelText: "Year Published",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    CheckboxListTile(
                      value: isRead,
                      title: const Text("Mark as Read"),
                      onChanged: (value) {
                        setState(() {
                          isRead = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final yearText = yearController.text;
                    final year = int.tryParse(yearText);

                    if (year == null) {
                      // Show error if input is not a number
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a valid year"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // Stop saving
                    }

                    final newBook = BookModel(
                      title: titleController.text,
                      author: authorController.text,
                      yearPublished: year,
                      isRead: isRead,
                    );

                    final vm = Provider.of<BookViewModel>(
                      context,
                      listen: false,
                    );

                    if (index == null) {
                      vm.addBook(newBook);
                    } else {
                      vm.updateBook(index, newBook);
                    }

                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
