import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:self_d_c/model/todo.dart';
import 'package:self_d_c/page/home_page.dart';
import 'package:self_d_c/api/firebase_api.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> allTodos = [];
  List<Todo> get notCompletedtodos =>
      allTodos.where((todo) => todo.isDone == false).toList();
  List<Todo> todosCompleted = [];

  void setTodos(List<Todo> todos) {
    allTodos = todos;
  }

  void addTodo(Todo todo) {
    allTodos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    firebase.deleteTodo(todo);

    // notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    todosCompleted = allTodos.where((todo) => todo.isDone == true).toList();
    allTodos.remove(todo);
    // await firebase.deleteTodo(todo);
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title) {
    todo.title = title;
    // todo.quantity = quantity;
    firebase.updateTodo(todo);
    //notifyListeners();
    // FirebaseApi.updateTodo(todo);
  }

  //get firestore instance
  //var dbref = FirebaseFirestore.instance.collection('Orders');

}
