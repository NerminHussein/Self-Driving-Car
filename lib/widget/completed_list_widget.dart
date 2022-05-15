import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_d_c/api/firebase_api.dart';
import 'package:self_d_c/provider/todos.dart';
import 'package:self_d_c/widget/todo_widget.dart';

class CompletedListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    //hna ghyrtaha le todos w elly a3mal 3leh check yb2a khlas w el todos feha kol el Orders updated day 3/3/2022
    //final todos=provider.todosCompleted;
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? Center(
            child:
             Text(
              'No completed tasks.',
              style: TextStyle(fontSize: 20),
            ),
            
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
               

              return TodoWidget(todo: todo);
            },
          );
          
  }
}