import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_d_c/loginPage.dart';
import 'package:self_d_c/secondhome.dart';
import 'package:self_d_c/homescreen.dart';
import 'package:self_d_c/createQRcode.dart';
import 'package:self_d_c/mainQR.dart';
import 'Register.dart';
import 'package:self_d_c/mainlist.dart';


/*class OrderInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   
  }



 subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }
}*/





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:self_d_c/loading.dart';
import 'package:self_d_c/secondhome.dart';


import 'MainPage.dart';
import 'Register.dart';
import 'googlemap.dart';

class OrderInfo extends StatelessWidget
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
        /*    Row(
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
                      child: Text("Sign Out",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18),),
                    ),

                  )

                ],
              ),*/

              firstpart(),



              Container(height:MediaQuery.of(context).size.height/3+MediaQuery.of(context).size.height/3,child: secondPart())



            ],



          ),
          ]
      ),



    );
  }

}


class firstpart extends StatelessWidget
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
            Text("Make Your Order" ,style: TextStyle(fontSize: 48,fontWeight: FontWeight.w900,color: Colors.white),),
            SizedBox(height: 10,),
            Text("Welcome To Our App" ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,color: Colors.white),),
          ],
        ),
      );
  }



}

class secondPart extends StatelessWidget

{

  final  current_user = FirebaseAuth.instance.currentUser;
 
  static String _quantity  ="";
static String _textorder="";
   bool _boolDone=false;
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
               onChanged: (value) =>  _textorder=value
                ,
                keyboardType: TextInputType.text,

                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFe7edeb),
                    hintText: "Your Order",
                    prefixIcon: Icon(Icons.add_shopping_cart,color: Colors.grey[800],)
                ),
              ),
            ),


            SizedBox(height: 20,),



            Padding(
              padding: EdgeInsets.only(left: 80,right: 80),
              child: TextFormField(
                onChanged: (value)
                {
                  _quantity=value;
                },

                keyboardType: TextInputType.number,
               // obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFe7edeb),
                    hintText: "Quantity",
                    prefixIcon: Icon(Icons.add,color: Colors.grey[800],)
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
                child: Text("Continue",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                onPressed: () async {


                  try {



                   if (_quantity==""&& _textorder=="" )
                  {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Quantity  and Order is Empty "),backgroundColor: Colors.blueGrey,));

                  }
                  else  if(_textorder==null || _textorder=="")
               {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text (" Order is Empty "),backgroundColor: Colors.blueGrey,));
                    }
                    else if(_quantity==null || _quantity=="")
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("quantity  is Empty "),backgroundColor: Colors.blueGrey,));
                    }


                    else {

        

                          var userInfo = FirebaseFirestore.instance.collection("orders").doc().set({
                             "order":_textorder,
                             "quantity":_quantity,
                             "isDone":_boolDone,
                              'user':{
                        'uid':current_user.uid,
                        'email':current_user.email,}
                           });

                            
                       //   if (userInfo != null) {

                      /*        var userInfo = FirebaseFirestore.instance.collection("Users").doc(user.user.uid).set({
                             "Email":_emaill,
                             "Password":_passw,
                           });*/
                           
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return secondHome();
                            },
                            ),
                            );
                         // }



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
/*subtract() {
    if (_quantity > 1) {
      
        _quantity--;
        print(_quantity);
      
    }
  }

  add() {
    
      _quantity++;
      print(_quantity);
    
  }

}*/
}

 