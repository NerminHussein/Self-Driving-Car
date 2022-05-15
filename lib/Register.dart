import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_d_c/order_info.dart';
import 'package:self_d_c/secondhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginPage.dart';

import 'package:self_d_c/mainlist.dart';

import 'MainPage.dart';
import 'googlemap.dart';
import 'loading.dart';



String _StringOfQRCode='';
class Register extends StatelessWidget
{
  final  _auth = FirebaseAuth.instance;
  String _email ="";
  String _pass ="";

     String code1 ="123468ABC";
   String code2 ="123478CDE";
   String code3 ="123488EFG";




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80,),

            Column(

              children: <Widget>[
                Text("Sign Up" ,style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),

                Text("Create an free account ",style: TextStyle(fontSize: 15,color: Colors.grey[700]),)



              ],

            ),

            SizedBox(height: 70),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 17,right: 17),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFe7edeb),
                        hintText: "UserName",
                        prefixIcon: Icon(Icons.email,color: Colors.grey[800],)
                    ),
                  ),
                ),

Padding(padding: EdgeInsets.only(left: 22,top: 5),child:  Text("[Optional]"),),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.only(left: 17,right: 17),
                  child: TextFormField(
                   onChanged: (value){
                     _email=value;
                   },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFe7edeb),
                        hintText: "E-mail address",
                        prefixIcon: Icon(Icons.email,color: Colors.grey[800],)
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 17,right: 17),
                  child: TextFormField(
                    onChanged: (value)
                    {
                      _pass=value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFe7edeb),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock,color: Colors.grey[800],)
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 17,right: 17),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFe7edeb),
                        hintText: " Confirm  Password",
                        prefixIcon: Icon(Icons.lock,color: Colors.grey[800],)
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left:22,top: 5),child:  Text("[Optional]"),),





              ],

            ),

            SizedBox(height: 55,),

            Container(

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(50),
                border: Border(
                  bottom: BorderSide(color: Colors.white38),
                  top: BorderSide(color: Colors.white38),
                  left: BorderSide(color: Colors.white38),
                  right: BorderSide(color: Colors.white38),
                ),
              ),
              child: MaterialButton(

                minWidth:MediaQuery.of(context).size.width/2,
                height: 50,
                color: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Text("Sign Up",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                onPressed: () async {





try {

  if (_pass=="" && _email=="")
    {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Both E-mail address and Password is Empty "),backgroundColor: Colors.blueGrey,));
     }
    else if(_email==null || _email=="")
    {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("E-mail address  is Empty "),backgroundColor: Colors.blueGrey,));
    }
    else if(_pass==null || _pass=="")
    {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("password  is Empty "),backgroundColor: Colors.blueGrey,));
    }
/*else {
    final user = await _auth.createUserWithEmailAndPassword(
    email: _email,
    password: _pass);

    if(user!=null) {
      var userInfo = FirebaseFirestore.instance.collection("Users").doc(user.user.uid).set({
                             "Email":_email,
                             "Password":_pass,
                             "ID":user.user.uid
                           });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
    return secondHome();
    },),);
    }

    }*/

    else {
    final user = await _auth.createUserWithEmailAndPassword(
    email: _email,
    password: _pass);
    _StringOfQRCode=user.user.uid;
    
    if(user!=null){
      if(_pass==code1 || _pass==code2||_pass==code3){
        var userInfo = FirebaseFirestore.instance.collection("Employees").doc(user.user.uid).set({
                             "Email":_email,
                             "Password":_pass,
                            " ID":user.user.uid,
                           });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
    return MyTodo();
    },),);
    }

    else{
 var userInfo = FirebaseFirestore.instance.collection("Users").doc(user.user.uid).set({
                             "Email":_email,
                             "Password":_pass,
                             "ID":user.user.uid,
                           });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Login();
    },),);
    }

    }
    

   /* if(user!=null) {
      var userInfo = FirebaseFirestore.instance.collection("Employees").doc(user.user.uid).set({
                             "Email":_email,
                             "Password":_uniqueID,
                           //  "Unique ID":_uniqueID,
                           });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
    return MyTodo();
    },),);
    }*/

    }
}on FirebaseAuthException catch(error)
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text (error.message,),backgroundColor: Colors.blueGrey,));
}




                },

              ),
            ),

            SizedBox(height: 30,),
          ],


        ),


      ),
    );
  }


}