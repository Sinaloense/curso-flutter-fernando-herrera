import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// import 'package:componentes/src/pages/home_temp.dart';
// import 'package:componentes/src/pages/home_page.dart';
import 'package:componentes/src/routes/routes.dart';
import 'package:componentes/src/pages/alert_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefaultCacheManager().emptyCache();

    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('es'), // Español
      ],
      // home: HomePageTemp()
      // home: HomePage(),
      initialRoute: '/',
      routes: getApplicationRoutes(),
      // Cuando la ruta no exista
      onGenerateRoute: (RouteSettings settings) {
        print('Ruta llamada: ${ settings.name }');

        return MaterialPageRoute(
          builder: (BuildContext context) => AlertPage()
        );
      },
    );
  }
}