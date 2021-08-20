import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:provider_tema/src/blocs/theme.dart';

import 'package:provider_tema/src/pages/home.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ThemeChanger(ThemeData.dark())),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      title: 'Material App',
      home: HomePage(),
    );
  }
}