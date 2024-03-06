import 'package:flutter/material.dart';
import 'package:flutter_project/pages/add_ToDo_screen.dart';
import 'package:flutter_project/pages/ToDo_details_screen.dart';

class ToDo {
  final String title;
  final String description;
  bool completed;

  ToDo({
    required this.title,
    required this.description,
    this.completed = false, 
  });
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<ToDo> ToDos = [
    ToDo(
      title: 'Flutter Project',
      description: 'Deadline: Tuesday',
    ),
    ToDo(
      title: 'Node Project',
      description: 'Deadline: Sunday',
    ),
    ToDo(
      title: 'Project',
      description: 'No deadline',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.account_circle_rounded,
          color: Colors.deepPurpleAccent,
        ),
        title: Text(
          'My to-dos',
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.end,
        ),
      ),
      body: ListView.builder(
        itemCount: ToDos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ToDos[index].title,
                            style: TextStyle(
                              decoration: ToDos[index].completed ? TextDecoration.lineThrough : TextDecoration.none,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              ToDos[index].completed ? Icons.check_box : Icons.check_box_outline_blank,
                              color: ToDos[index].completed ? Colors.green : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                ToDos[index].completed = !ToDos[index].completed;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ToDoDetailsScreen(
                            title: ToDos[index].title,
                            description: ToDos[index].description,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newToDo = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddToDoScreen(
                onToDoAdded: (title, description) {
                  if (title.isNotEmpty || description.isNotEmpty) {
                    setState(() {
                      ToDos.add(ToDo(
                        title: title,
                        description: description,
                      ));
                    });
                  }
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
