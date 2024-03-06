import 'package:flutter/material.dart';
import 'package:flutter_project/pages/ToDo_list_screen.dart';
import 'package:flutter_project/pages/add_ToDo_screen.dart';
import 'package:flutter_project/pages/ToDo_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo Taking App',
      initialRoute: '/',
      routes: {
        '/': (context) => ToDoListScreen(),
        '/add': (context) => AddToDoScreen(
          onToDoAdded: (title, description) {
            print('To Do added - Title: $title, Description: $description');
          },
        ),
        '/details': (context) {
          final Map<String, dynamic>? args =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          final String title = args?['title'] ?? '';
          final String description = args?['description'] ?? '';
          return ToDoDetailsScreen(title: title, description: description);
        },
      },
    );
  }
}
