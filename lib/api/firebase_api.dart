import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:self_d_c/model/todo.dart';
import 'package:self_d_c/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firebase {
  static var current_user = FirebaseAuth.instance.currentUser;
  static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('orders')
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));

  static Future deleteTodo(Todo todo) async {
    final docTodo =
        FirebaseFirestore.instance.collection('orders').doc(todo.title);
    print("DocTodo Is Deleted" + todo.id);
    await docTodo.delete();
  }

  static Future updateTodo(Todo todo) async {
    final docTodo =
        FirebaseFirestore.instance.collection('orders').doc(todo.title);
    await docTodo.update(todo.toJson());
  }
  /*  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('Orders').doc(todo.title);

    await docTodo.update(todo.toJson());
  }*/

}
