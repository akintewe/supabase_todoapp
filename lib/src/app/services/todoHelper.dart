import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:todoapp/src/app/models/todoModel.dart';

class TodoDatabaseHelper {
  final DatabaseReference _todoDatabase =
      FirebaseDatabase.instance.reference().child('todos');

  Future<void> addTodo(Todo todo, String userId) async {
    await _todoDatabase.child(userId).push().set({
      'title': todo.title,
      'description': todo.description,
      'isCompleted': todo.isCompleted,
    });
  }

  Future<void> updateTodo(Todo todo, String userId, String todoId) async {
    await _todoDatabase.child(userId).child(todoId).update({
      'title': todo.title,
      'description': todo.description,
      'isCompleted': todo.isCompleted,
    });
  }

  Future<void> deleteTodo(String todoId, String userId) async {
    await _todoDatabase.child(userId).child(todoId).remove();
  }

  StreamController<List<Todo>> _todosStreamController = StreamController<List<Todo>>();

  Stream<List<Todo>> get todosStream => _todosStreamController.stream;


  Future<void> getTodos(String userId) async {
    _todoDatabase.child(userId).onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic>? data = dataSnapshot.value as Map<dynamic, dynamic>?;

      List<Todo> todos = [];

      if (data != null) {
        data.forEach((key, value) {
          Todo todo = Todo(
            id: key,
            title: value['title'],
            description: value['description'],
            isCompleted: value['isCompleted'],
          );
          todos.add(todo);
        });
      }

      _todosStreamController.add(todos);
    });
  }
}




