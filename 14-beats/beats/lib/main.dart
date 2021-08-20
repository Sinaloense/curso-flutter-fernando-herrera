import 'package:flutter/material.dart';

import 'package:beats/src/pages/home.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beats App',
      initialRoute: 'home',
      routes: {
        HomePage().route : (BuildContext context) => HomePage(),
      },
    );
  }
}