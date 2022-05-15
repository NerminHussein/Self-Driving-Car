
import 'dart:math';

//import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:self_d_c/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:self_d_c/model/todo.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'utils.dart';
import 'dart:async';
import 'package:self_d_c/api/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class QRCreatePage extends StatefulWidget {
  @override
  
  _QRCreatePageState createState() => _QRCreatePageState();
}

class _QRCreatePageState extends State<QRCreatePage> {


  dynamic dataQR;

  Future<dynamic> getData() async {

    final DocumentReference document =   FirebaseFirestore.instance.collection("orders").doc('dclPWEd76DtbO6mBU01R');

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
     setState(() {
       dataQR =snapshot.data;
     });
    });
 }
  var current_user =  FirebaseAuth.instance;
  final controller = TextEditingController();
  Random random=Random(1000);
  var typeNumberr = 4;
var errorCorrectionLevell = 'L';
//final controllerQR = Barcode.qrCode();
Todo todo;

  @override

   void initState() {

    super.initState();
    getData();
  }

  
  Widget build(BuildContext context) => Scaffold(
   
        appBar: AppBar(
          title: Text("QR Code"),backgroundColor: Colors.teal,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                QrImage(
                  //barcode: Barcode.qrCode(),
                  backgroundColor: Colors.white,
                  data:  dataQR['order'],
                  
                  
               //   width: 200,
              //  height: 200,
                ),
               
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(child: buildTextField(context)),
                    const SizedBox(width: 12,),
                    FloatingActionButton(
                      
                      backgroundColor: Colors.white,
                      child: Icon(Icons.done, size: 30,color: Colors.teal,),
                      
                      onPressed: () => setState(() {
                     //   Key _formkey;
                   //  var current_user_for_order=await FirebaseAuth.instance.currentUser();
                        //store order
                        
                        var result =  FirebaseFirestore.instance.collection('QRs').doc().set({
                          'QR Image':dataQR['order'] ,
                          
                          
                         
                     //   'QR': controllerQR.toSvgBytes() ,
                        });
                        // store qr
                       // var result2 =  FirebaseFirestore.instance.collection('QR').add({'QR':Barcode.qrCode() });

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Order Will Arrives in 20 Minutes "),backgroundColor: Colors.blueGrey,));
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildTextField(BuildContext context) => TextField(
    
        controller: controller,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: 'Enter Your Order',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.teal),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
        ),
      );

}




  /* Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('orders')
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));


 Future<List> fetchAllContact() async {
    List contactList = [];
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('orders').doc('dclPWEd76DtbO6mBU01R').get();
    contactList = documentSnapshot.data();
    return contactList;
  }*/


/*Widget returnTextQR(BuildContext context){

 Text(data['name'])
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("geeksforgeeks"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

  
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                child: Center(child: Text(document['text'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }*/

