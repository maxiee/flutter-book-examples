import 'package:flutter/material.dart';
import 'package:todo/data/TodoManager.dart';
import 'package:todo/model/Todo.dart';

class TodoState with ChangeNotifier {
  List<Todo> todoList = [];

  void createTodo(Todo todo) async {
    await TodoManager.createTodo(todo);
    todoList.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) async {
    await TodoManager.updateTodo(todo);

    int index = todoList.indexWhere(
            (element) => element.id == todo.id);
    todoList[index] = todo;
    notifyListeners();
  }

  void getAllTodo() async {
    todoList = await TodoManager.getAllTodo();
    notifyListeners();
  }
}