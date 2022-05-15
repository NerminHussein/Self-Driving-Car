import 'package:flutter/material.dart';
import 'package:self_d_c/googlemap.dart';

import 'mapscreen2.dart';


class secondHome extends StatelessWidget
{
  const secondHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          backgroundColor:Colors.teal,
          title: Text("Select your Map "),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search))
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          scrollDirection: Axis.vertical,
          children:<Widget> [

         Hero(
                tag: "logo",
                child: Padding(
                  padding: EdgeInsets.only(left: 70,right: 70,top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("images/pointer.jpg"),
                          fit: BoxFit.contain,
                        )

                    ),
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),





            SizedBox(height: 20,),




            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [

                Padding(
                  padding: EdgeInsets.only(left: 6,right: 0),
                  child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width/2-10,
                      child:  MaterialButton(

                        //  minWidth:MediaQuery.of(context).size.width/2,
                          height: 55,
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          child: Text("Global Map",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return GlobalSreen();
                            },

                            ),
                            );
                          }
                      )
                  ),
                ),

SizedBox(width: 8,),
                Padding(
                  padding: EdgeInsets.only(left: 0,right: 6),
                  child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width/2-10,
                      child:  MaterialButton(

                        //  minWidth:MediaQuery.of(context).size.width/2,
                          height: 55,
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          child: Text("Local Map",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return localmap();
                            },

                            ),
                            );
                          }
                      )
                  ),
                ),





              ],


            ),




            SizedBox(height: 50,),

          ],


        ),



      ),
    );
  }












}