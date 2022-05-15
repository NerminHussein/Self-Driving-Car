import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:self_d_c/loading.dart';
import 'package:self_d_c/mainlist.dart';
import 'package:self_d_c/secondhome.dart';


import 'MainPage.dart';
import 'Register.dart';
import 'googlemap.dart';

class LoginEmp extends StatelessWidget
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

  final  _auth = FirebaseAuth.instance;
 static String _emaill ="" ;
 static String _passw  ="";
 static String _uniquecode="";


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
  /*          SizedBox(height: 20,),

               Padding(
              padding: EdgeInsets.only(left: 17,right: 17),
              child: TextFormField(
               onChanged: (value) =>  _uniquecode=value
                ,
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFe7edeb),
                    hintText: "Code",
                    prefixIcon: Icon(Icons.code,color: Colors.grey[800],)
                ),
              ),
            ),
*/

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

    

                           //  var userInfo = FirebaseFirestore.instance.collection("Employees").doc().;
                           if(user!=null){
                           
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return MyTodo();
                            },),);
                          
                              
                           }
                           else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Error Message"),backgroundColor: Colors.blueGrey,)); 
                           }
                         
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