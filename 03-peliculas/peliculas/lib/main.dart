import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
        ],
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        DetailsScreen.routeName: (_) => DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
        color: Colors.indigo,
      )),
    );
  }
}
