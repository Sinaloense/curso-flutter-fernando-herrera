import 'package:flutter/material.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DefaultCacheManager().emptyCache();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/'           : (BuildContext context) => HomePage(),
        'detalle'     : (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}