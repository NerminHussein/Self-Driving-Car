import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_d_c/homescreen.dart';
import 'package:self_d_c/mapscreen2.dart';
import 'package:self_d_c/user.dart';
import 'loginPage.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Google Map',
        color: Colors.teal,
        debugShowCheckedModeBanner: false,
        home: user()
    );
  }
}

