import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:provider_app/src/providers/heroesinfo.dart';
import 'package:provider_app/src/providers/villanosinfo.dart';

import 'package:provider_app/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //       create: (BuildContext context) => HeroesInfo(),
  //       child: MaterialApp(
  //         debugShowCheckedModeBanner: false,
  //         title: 'Material App',
  //         initialRoute: HomePage().route,
  //         routes: {
  //           HomePage().route : (BuildContext context) => HomePage()
  //         },
  //       ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context) => HeroesInfo()),
          ChangeNotifierProvider(create: (BuildContext context) => VillanosInfo()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: HomePage().route,
          routes: {
            HomePage().route : (BuildContext context) => HomePage()
          },
        ),
    );
  }
}