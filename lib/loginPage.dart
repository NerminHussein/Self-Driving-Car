

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:self_d_c/loading.dart';
import 'package:self_d_c/mainlist.dart';
import 'package:self_d_c/secondhome.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:self_d_c/user.dart';


import 'MainPage.dart';
import 'order_info.dart';
import 'Register.dart';
import 'googlemap.dart';




String _StringOfQRCode='';
 final  _auth = FirebaseAuth.instance;
class Login extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Colors.teal,
      body: ListView(
          children:<Widget> [Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){

                        return Register();
                      }));
                    },

                    child: Container(
                      color: Colors.teal,
                      height: 50,
                      width: 65,
                      child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18),),
                    ),

                  )

                ],
              ),

              firstHave(),



              Container(height:MediaQuery.of(context).size.height/3+MediaQuery.of(context).size.height/3,child: secondHave())



            ],



          ),
          ]
      ),



    );
  }

}


class firstHave extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
        color: Colors.teal,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Sign In" ,style: TextStyle(fontSize: 48,fontWeight: FontWeight.w900,color: Colors.white),),
            SizedBox(height: 10,),
            Text("Welcome To Our App" ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,color: Colors.white),),
          ],
        ),
      );
  }



}

class secondHave extends StatelessWidget

{

 
 static String _emaill ="" ;
 static String _passw  ="";
    String code1 ="123468ABC";
   String code2 ="123478CDE";
   String code3 ="123488EFG";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight:  Radius.circular(40)),

      ),


        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 17,right: 17),
              child: TextFormField(
               onChanged: (value) =>  _emaill=value
                ,
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
                  _passw=value;
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
            SizedBox(height: 50,),

            Container(
              height: 50,
              width: MediaQuery.of(context).size.width/3+55,
              child:  MaterialButton(

                minWidth:MediaQuery.of(context).size.width/2,
                height: 50,
                color: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Text("Sign In",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                onPressed: () async {


                  try {



                   if (_passw=="" && _emaill=="")
                  {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Both E-mail address and Password is Empty "),backgroundColor: Colors.blueGrey,));

                  }
                  else  if(_emaill==null || _emaill=="")
               {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("E-mail address is Empty "),backgroundColor: Colors.blueGrey,));
                    }
                    else if(_passw==null || _passw=="")
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("password  is Empty "),backgroundColor: Colors.blueGrey,));
                    }


                    else {

final user = await _auth.signInWithEmailAndPassword(
                              email: _emaill,
                              password: _passw);
                             
_StringOfQRCode=user.user.uid;

if(_passw==code1 || _passw==code2 || _passw==code3 ){
  
                                if(user!=null){
                                 Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return MyTodo();
                            },),);
                            
                               
                                }
                                }
                                 else{
                                 

                        if(user!=null){

                      /*        var userInfo = FirebaseFirestore.instance.collection("Users").doc(user.user.uid).set({
                             "Email":_emaill,
                             "Password":_passw,
                           });*/
                           
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return OrderInfo();
                            },),);
                          

}
                                 
                              }

                        
                  /*        if (user != null) {

                      /*        var userInfo = FirebaseFirestore.instance.collection("Users").doc(user.user.uid).set({
                             "Email":_emaill,
                             "Password":_passw,
                           });*/
                           
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return OrderInfo();
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


          ],



        ),

    );
  }

}


class QRCreatePagee extends StatefulWidget {
  @override
  
  _QRCreatePageState createState() => _QRCreatePageState();
}

class _QRCreatePageState extends State<QRCreatePagee> {


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
  @override  
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
                 Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("images/pointer.jpg"),
                          fit: BoxFit.contain,
                        )

                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
               SizedBox(height: 40 ),
              Text("Your QR Code Is ,You should take screenshot to recieve your order .... ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black)),
               SizedBox(height: 40),
                QrImage(
                  data:_StringOfQRCode ,
                  //barcode: Barcode.qrCode(),
                  backgroundColor: Colors.white,
                  version: QrVersions.auto,
                  size: 250,
                 // embeddedImage: AssetImage('assets/images/QR.png'),
                /*  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(80, 80),
                   
                  ),*/
                  
                  
                  
               //   width: 200,
              //  height: 200,
                ),
                //_StringOfQRCode._oDrawing._elCanvas.toDataURL("image/png"),
                SizedBox(height: 40),
                 Text("Thank you for trusting us for using our app",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black)),
                    const SizedBox(width: 12,),
                    SizedBox(height: 40),
                Row(
                  children: [
                 //   Expanded(child: buildTextField(context)),
                
                    
              Container(
              height: 50,
              width: MediaQuery.of(context).size.width/3+55,
              child:  MaterialButton(

               minWidth: MediaQuery.of(context).size.width,
                height: 50,
                color: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Text("Sign out",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                      
                      onPressed: () async {
                     //   Key _formkey;
                   //  var current_user_for_order=await FirebaseAuth.instance.currentUser();
                        //store order
                        
                        var result =  FirebaseFirestore.instance.collection('QRs').doc().set({
                          'QRString':current_user.currentUser.uid,
                     //   'QR': controllerQR.toSvgBytes() ,
                        });
                        current_user.signOut();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Order Will Arrives in 20 Minutes "),backgroundColor: Colors.blueGrey,));
                    exit(4);
                      }),
                   ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
