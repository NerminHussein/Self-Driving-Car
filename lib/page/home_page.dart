import 'package:flutter/material.dart';
import 'package:self_d_c/mainlist.dart';
import 'package:provider/provider.dart';
import 'package:self_d_c/widget/add_todo_dialog_widget.dart';
import 'package:self_d_c/widget/completed_list_widget.dart';
import 'package:self_d_c/widget/todo_list_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:self_d_c/model/todo.dart';
import 'package:self_d_c/provider/todos.dart';
import 'package:self_d_c/api/firebase_api.dart';

String DataOfOrder = '';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final tabs = [
    //TododList Container
    TodoListWidget(),
    //Complete Container
    CompletedListWidget(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //el main page
      appBar: AppBar(
        title: Text(MyTodo.title),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        //unselectedItemColor  if complete or not
        unselectedItemColor: Colors.white.withOpacity(0.7),
        //selectedItemColor if complete or not
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          //Bar navigator that contaion complete and todolist
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed',
          ),
        ],
      ),

      //  body: tabs[selectedIndex],
      body: StreamBuilder<List<Todo>>(
        stream: firebase.readTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final todos = snapshot.data;
                int counter = snapshot.data.length;
                final provider = Provider.of<TodosProvider>(context);
                provider.allTodos = todos;

                //  print(todos );
                return tabs[selectedIndex];
              }
          }
        },
      ),
      /*  floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        // Da el Button that make Add Todo But i retrieve Data from Fire base Not Create Data 

        //elcomment da 3malt fretriev f another page
 /*    onPressed: () => showDialog(
       
          context: context,
          builder: (context) => retrieve(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
        */

        onPressed: () => showDialog(
       
          context: context,
          builder: (context) => retrieve(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),*/
    );
  }
}

/*class retrieve extends StatelessWidget{
 
@override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     home: Dialog(
       child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
  
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                child: Center(child: Text(DataOfOrder= document['Order'])),
              );
            }).toList(),
          );
        },
      ),
     ),

   );
  }
  }*/

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
