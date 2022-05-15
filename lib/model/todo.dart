import 'package:flutter/cupertino.dart';
import 'package:self_d_c/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  var current_user=FirebaseAuth.instance.currentUser;
  //DateTime createdTime;
  String title;
  String id;
  String quantity;
  bool isDone;

  Todo({
   // @required this.createdTime,
    @required this.title,
    this.quantity = '',
    this.id ,
    //kont ktbha isdone=true
    this.isDone ,
  });


   static Todo fromJson(Map<String, dynamic> json) => Todo(
       // createdTime: Utils.toDateTime(json['createdTime']),
        title: json['order'],
        quantity: json['quantity'],
        id: json['uid'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
       // 'createdTime': Utils.fromDateTimeToJson(createdTime),
        'order': title,
        'quantity': quantity,
        'uid': id,
        'isDone': isDone,
      };
}