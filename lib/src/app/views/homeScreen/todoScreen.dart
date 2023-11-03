import 'package:flutter/material.dart';
import 'package:todoapp/src/app/models/todoModel.dart';
import 'package:todoapp/src/app/services/todoHelper.dart';

class TodoScreen extends StatefulWidget {
  final String userId;

  TodoScreen({required this.userId});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoDatabaseHelper _todoDatabaseHelper = TodoDatabaseHelper();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _todoDatabaseHelper.getTodos(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 300,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Welcome to StoreTodo 😊',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: _todoDatabaseHelper.todosStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/checklist.png'),
                  Text(
                    'What do you want to do today?',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Todo todo = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(44, 1, 86, 1),
                          Color.fromRGBO(68, 51, 85, 1)
                        ], // Specify your gradient colors here
                        begin: Alignment
                            .centerLeft, // Specify the alignment of the gradient
                        end: Alignment
                            .centerRight, // Specify the alignment of the gradient
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        todo.description,
                        style: TextStyle(
                            color: Color.fromARGB(78, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Color.fromRGBO(136, 117, 255, 1),
                            ),
                            onPressed: () {
                              _showEditDialog(todo);
                              // Implement edit functionality
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm Deletion'),
                                    content: Text(
                                        'Are you sure you want to delete this todo item?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _todoDatabaseHelper.deleteTodo(
                                              todo.id, widget.userId);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showEditDialog(Todo todo) {
    TextEditingController _editTitleController =
        TextEditingController(text: todo.title);
    TextEditingController _editDescriptionController =
        TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Todo Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editTitleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _editDescriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Update the todo item in the database
                Todo updatedTodo = Todo(
                  id: todo.id,
                  title: _editTitleController.text,
                  description: _editDescriptionController.text,
                  isCompleted: todo.isCompleted,
                );

                _todoDatabaseHelper.updateTodo(
                    updatedTodo, widget.userId, todo.id);

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
