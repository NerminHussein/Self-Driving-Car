import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:self_d_c/directions_model.dart';
import 'package:self_d_c/directions_repository.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:self_d_c/loginPage.dart';

class GlobalSreen extends StatefulWidget {
 

  @override
  _MapSreenState createState() => _MapSreenState();
}

class _MapSreenState extends State<GlobalSreen> {

List<Map<double,double>> latng; 
 var current_user =  FirebaseAuth.instance.currentUser;
  static const _initalcameraposition =CameraPosition(
      target:LatLng(30.078,31.28492) ,
      zoom: 18.0);

    GoogleMapController _googleMapController ;

    TextEditingController _from =TextEditingController();
    TextEditingController _to =TextEditingController();

  Marker _Origin;
  Marker _destination;
  Polyline _polyline;
  Directions _info;
 // Directions ? _info;

  @override
  void dispose() {
    _googleMapController.dispose();

    super.dispose();
  }

  void _addmarker (LatLng pos) async
  {
    if(_Origin== null ||  (_Origin!= null&&_destination!=null))
    {
      setState(() {
        _Origin=Marker(
          markerId: const MarkerId("Origin"),
          infoWindow: const InfoWindow(title: "Origin"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,

        );

_from.text=(_Origin.position.latitude).toString()+" && "+(_Origin.position.longitude).toString();
_to.clear();

        _destination=   null ;
        _polyline=null;
//_info=null;
      });
    }
    else
    {

      setState(() {

        _destination=Marker(
          markerId: const MarkerId("destination"),
          infoWindow: const InfoWindow(title: "destination"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,

        );
        _to.text=(_destination.position.latitude).toString()+" && "+(_destination.position.longitude).toString();
        //polyline da elly hsavoh f el firebase
        _polyline =Polyline(
               polylineId: const PolylineId('Path'),
              color: Colors.blueGrey,
             width: 2,
            points:[
              LatLng(_Origin.position.latitude, _Origin.position.longitude),
              LatLng(_destination.position.latitude, _destination.position.longitude)

            ],
            );


        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Order Will Arrives in 45 minnutes "),backgroundColor: Colors.blueGrey,));




      });

        final directions =await DirectionsRepository().getDirections(origin: _Origin.position, destination:pos);
       setState(()=>_info=directions);


    }


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: false,
        title: const Text("Select Locations"),

        actions: [
          if(_Origin!=null)
            TextButton(onPressed: ()=>_googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _Origin.position,zoom: 14.5,tilt: 50.0)))
              ,
              style: TextButton.styleFrom(primary: Colors.black87,
                  textStyle: TextStyle(fontWeight: FontWeight.w600))

              ,child:const Text("ORIGIN") ,),

          if(_destination!=null)
            TextButton(onPressed: ()=>_googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _destination.position,zoom: 14.5,tilt: 50.0)))
              ,
              style: TextButton.styleFrom(primary: Colors.black87,
                  textStyle: TextStyle(fontWeight: FontWeight.w600))

              ,child:const Text("DEST") ,),


        ],

      ),
      body: Stack(
alignment: Alignment.topCenter,
          children:[

                Material(
                  elevation: 1,
                  child: Container(
height: MediaQuery.of(context).size.height/5,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(8),

                    ),
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [

SizedBox(height: 3,),
                         Padding(
                           padding: const EdgeInsets.only(left: 7,right: 7),
                           child: Container(

                             width: MediaQuery.of(context).size.width,
                             child: TextField(
controller: _from,
keyboardType: TextInputType.none,
                               decoration: InputDecoration(
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(8),
                                     borderSide: BorderSide.none,
                                   ),
                                   filled: true,
                                   fillColor: Colors.green[50],
                                   hintText: "From Where..",
                                   prefixIcon: Icon(Icons.location_on_outlined,color: Colors.grey[800],)
                               ),
                             ),
                           ),
                         ),
          SizedBox(height: 3,),
          Padding(
            padding: const EdgeInsets.only(left: 7,right: 7),
            child: Container(
              width:MediaQuery.of(context).size.width,
              child: TextField(
controller: _to,
                               keyboardType: TextInputType.none,
                               decoration: InputDecoration(
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(8),
                                     borderSide: BorderSide.none,
                                   ),
                                   filled: true,
                                   fillColor: Colors.green[50],
                                   hintText: "To...",
                                   prefixIcon: Icon(Icons.location_on_outlined,color: Colors.grey[800],)
                               ),
                             ),
            ),
          ),



                     ],
               ),
                  ),
                ),
            Container(
              decoration: BoxDecoration(
borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/5+2),
              child: GoogleMap(

                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapType: MapType.normal,

                initialCameraPosition: _initalcameraposition,
                onMapCreated: (controller)=>_googleMapController=controller,
                //List of polyline elly h3mlha save in firebase
               // polylines: {
               //   if(_polyline!=null) _polyline
               // },
                markers: {

                  if(_Origin!=null) _Origin,
                  if(_destination!=null)_destination,

                },
                 polylines: {
              if (_info != null)
                Polyline(
                  //geodesic da na zawtoh
                  geodesic: true,
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                
                  width: 5,
                  points: _info.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                     
                ),
               // latng.add(_info.polylinePoints.map((e) => null))
                },
              

                onTap: _addmarker,
                // polylines: {

                // if(_info !=null)
                //   Polyline(
                //   polylineId: const PolylineId('overview_polyline'),
                //  color: Colors.red,
                // width: 5,
                //points: _info!.polylinepoints.map((e) => LatLng(e.latitude, e.longitude)).toList(),
                //),


                //},

              ),
            ),

            if(_info!= null)
            Positioned(top: 20.0,

            child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
            decoration: BoxDecoration(

             color: Colors.yellowAccent,
             borderRadius: BorderRadius.circular(20.0),
            boxShadow: const
             [
             BoxShadow(color: Colors.black26,
            offset: Offset(0,2),
            blurRadius: 6.0,
            )

               ]
               ),
               child: Text(
                 '${_info.totalDistance},${_info.totalDuration}',
                 style: const TextStyle(
                   fontWeight: FontWeight.w600,
                   fontSize: 18.0
                   ),
                   ),
                  
                   
                ),
                
             ),
           /*  Container(
               height: 50,
              width: MediaQuery.of(context).size.width/3+55,
              child:MaterialButton(
              height: 50,
              minWidth: 200,
                color: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Text("Continue",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                      
                      onPressed: () async {
                        var result =  FirebaseFirestore.instance.collection('Location').doc().set({
                          
                          'Path': _info.polylinePoints,
                          'user':{
                          'uid':current_user.uid,
                          'email':current_user.email,
                          
                      }
                        }
                        //  'QR': controllerQR,
                        ,);
                      }
             ) ,
             ),*/
             
          ]
      ),
      
      floatingActionButton: MaterialButton(
        
        color: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//foregroundColor: Colors.black,
        child: Text("Get Your QR",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
  //      backgroundColor: Colors.teal,
         onPressed: () {
           
  /*          _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initalcameraposition),

        );*/
        // latng=_info.polylinePoints.map((e) => PointLatLng(e.latitude, e.longitude)).toList();
       // latng.add(_info.polylinePoints.map((e)));
        var result =  FirebaseFirestore.instance.collection('Location').doc().set({
                          'Path': _info.polylinePoints.toString(),
                          'user':{
                          'uid':current_user.uid,
                          'email':current_user.email,   
                      }
         },
        );
               
              

//        onPressed: () {
        //  _googleMapController.animateCamera(CameraUpdate.newCameraPosition(_initalcameraposition));
          //_googleMapController.animateCamera(
          // _info !=null ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0):CameraUpdate.newCameraPosition(_initalcameraposition),
          //)

 //       }
        
        //child: const Icon(Icons.center_focus_strong),

      
        Navigator.push(context, MaterialPageRoute(builder: (context){
                    return QRCreatePagee();
                   },),
                   );

      


          }
     ) );


  }



}
