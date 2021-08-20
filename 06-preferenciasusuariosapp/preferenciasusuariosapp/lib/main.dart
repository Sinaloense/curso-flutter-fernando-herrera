import 'package:flutter/material.dart';

import 'package:preferenciasusuariosapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasusuariosapp/src/pages/home_page.dart';
import 'package:preferenciasusuariosapp/src/pages/settings_page.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preferencias',
      initialRoute: prefs.ultimPagina,
      routes: {
        HomePage.routeName        : (BuildContext context) => HomePage(),
        SettingsPage.routeName    : (BuildContext context) => SettingsPage(),
      },
    );
  }
}