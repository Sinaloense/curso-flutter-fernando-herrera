import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/provider.dart';

import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Validation',
        initialRoute: LoginPage.routeName,
        routes: {
          LoginPage.routeName : (BuildContext context) => LoginPage(),
          HomePage.routeName  : (BuildContext context) => HomePage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
  }
}