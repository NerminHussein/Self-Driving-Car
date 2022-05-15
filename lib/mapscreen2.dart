
import 'package:flutter/material.dart';
//import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_d_c/createQRcode.dart';
import 'package:self_d_c/mainQR.dart';
import 'package:firebase_storage/firebase_storage.dart' ;
import 'package:image_picker/image_picker.dart';
import 'request.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io' as Io;
import 'package:self_d_c/buttonwidget.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:self_d_c/loginPage.dart';


String imagestring= 'initial';

class localmap extends StatefulWidget {
  @override
  _localmapState createState() => _localmapState();
}

class _localmapState extends State<localmap> {

  int num1=1;
  int num2=1;
  TextEditingController from =TextEditingController();
  TextEditingController to =TextEditingController();
 String url='';
 var current_user =  FirebaseAuth.instance.currentUser;
  var Data;

  String QueryText = 'Query';

  final arr =[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          backgroundColor:Colors.teal,
          centerTitle: true,
          title: Text("Local Map "),

        ),
        backgroundColor: Colors.grey[200],
        body: ListView(
          scrollDirection: Axis.vertical,
          children:<Widget> [

            Material(
              elevation: 20,
              child: Padding(
                padding: EdgeInsets.only(left: 0,right: 0),
                child: Hero(
                  tag: "logo",
                    child: Container(

                      decoration: BoxDecoration(
                        //  borderRadius: BorderRadius.only( bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage("images/local.jpg"),
                            fit: BoxFit.fill,

                          )

                      ),
                      height: MediaQuery.of(context).size.height/2+100,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
              ),
            ),

SizedBox(height: 65,),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left:15,top: 5),child:  Text("to..!",style:TextStyle(fontWeight: FontWeight.bold) ,),),
              Padding(
                padding: EdgeInsets.only(left: 6,),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    width: 350,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey,width: 6)
                    ),
                    child:
                    TextField(
                onChanged: (value) {
                  url = 'http://192.168.1.100:5000/' + value.toString();
                },
                decoration: InputDecoration(
                    hintText: 'Enter the Dest',
                    suffixIcon: GestureDetector(
                        onTap: () async {
                          Data=await etData(url);
                          var DecodedData = jsonDecode(Data)   ;
                          setState(() {
                            QueryText = DecodedData["Path"].toString();
                            imagestring=DecodedData["imagestring"].toString();
                            
                            
                            //print(imagestring.toString());

                          });
                        },
                        
                        child: Icon(Icons.search,color: Colors.teal),)),
              ),
                    /*DropdownButtonHideUnderline
                      (child:  DropdownButton<int>(
                      alignment: Alignment.center,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down,color:Colors.black,),
                      value: num1,
                      iconSize: 36,
                      items:arr.map(buildmenu1).toList(),
                      onChanged: (value)=>setState(()=>this.num1=value),
                    ),)*/
                    
                ),
              ),

            ],

              

          ),
          /*     Column(

                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[


                 Padding(padding: EdgeInsets.only(left:15,top:6 ),child:  Text("To..!",style: TextStyle(fontWeight: FontWeight.bold),),),
                 Padding(
                   padding: EdgeInsets.only(right: 6,),
                   child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                       width: MediaQuery.of(context).size.width/2-25,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12),
                           border: Border.all(color: Colors.grey,width: 2)
                       ),
                       child:DropdownButtonHideUnderline
                         (child:  DropdownButton<int>(
                         alignment: Alignment.center,
                         isExpanded: true,
                         icon: Icon(Icons.arrow_drop_down,color:Colors.black,),
                         value: num2,
                         iconSize: 36,
                         items:arr.map(buildmenu1).toList(),
                         onChanged: (value)=>setState(()=>this.num2=value),
                       ),)
                   ),
                 ),
               ],)*/


]
            ),

            SizedBox(height: 19,),

            Padding(
              padding: EdgeInsets.only(left: 70,right: 70),
              child: MaterialButton(

                  minWidth:MediaQuery.of(context).size.width/2,
                  height: 52,
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: Text("Excute Order",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                  onPressed: ()  {

                  
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Order Will Arrives in 20 Minutes "),backgroundColor: Colors.blueGrey,));
                    
                    var result =  FirebaseFirestore.instance.collection('Location').doc().set({
                          'String image': imagestring,
                          'Path': QueryText,
                          'user':{
                          'uid':current_user.uid,
                          'email':current_user.email,
                      }

                        //  'QR': controllerQR,
                        });
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return imagexshow();
                   },),
                   );
                  }
              ),
            ),

SizedBox(height: 20,)




          ],


        ),



      ),
    );

  }


  DropdownMenuItem<int> buildmenu1(int item)=>DropdownMenuItem(
      value: item,
      child: Text("$item",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),));


  DropdownMenuItem<int> buildmenu2(int item)=>DropdownMenuItem(
      value: item,
      child: Text("$item",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),));


}

class imagexshow extends StatefulWidget {
  @override
  _imagexshowState createState() =>_imagexshowState();
}
class _imagexshowState extends State<imagexshow>{
var image1 = String;

Uint8List bytesImage= Base64Decoder().convert(imagestring);
  String imagelocalmap='assets/localmap.jpg';
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Local Map '),
        backgroundColor: Colors.teal,
      ),
      body:ListView(
        children: [
          new InkWell(
          child:      
          Image.memory(bytesImage),
          ),
   /*    MaterialButton(
             height: 52,
             minWidth: 20,
            color: Colors.teal,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Text("Get Your QR",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
            onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
                    return MyQR();
                   },),
                   );
          },),*/
//Button elly b ytl3 el QR Code AS Image
          ButtonWidget(
                text: 'Get Your QR',
                
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => QRCreatePagee(),
                )),
              
             
              ),
        ],
      ),
   /*   body: Center(
        
        child: 
        new InkWell(
          child:      
          Image.memory(bytesImage),
          ),
        ),*/
      );
  
    
  

}





}



