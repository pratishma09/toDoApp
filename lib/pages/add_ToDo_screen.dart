import 'package:flutter/material.dart';

class AddToDoScreen extends StatefulWidget {
  final Function(String, String) onToDoAdded;
  AddToDoScreen({required this.onToDoAdded});
  @override
  _AddToDoScreenState createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String? _titleErrorText; // Error text for the title field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a To-Do'),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveToDo();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                errorText: _titleErrorText, // Display error text if title is empty
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveToDo,
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveToDo() {
    String title = _titleController.text;
    String description = _descriptionController.text;
    //title empty nadinu
    if (title.isEmpty) {
      setState(() {
        _titleErrorText = 'Title cannot be empty';
      });
      return;
    }

    setState(() {
      _titleErrorText = null;
    });

    widget.onToDoAdded(title, description);
    Navigator.pop(context);
    _titleController.clear();
    _descriptionController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ToDo added successfully')),
    );
  }
}
