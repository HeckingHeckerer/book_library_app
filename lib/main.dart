import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/book_view_model.dart';
import 'views/book_library_view.dart';

// Entry point of the application.
// ChangeNotifierProvider makes BookViewModel available
// to the entire widget tree.

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BookViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Dark theme
        scaffoldBackgroundColor: Colors.black, // background for Scaffold
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true, // center the title
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white), // for buttons/icons
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // default text color
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const BookLibraryView(),
    );
  }
}
