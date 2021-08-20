import 'package:flutter/material.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:serviciosconfirebase/src/preferencias/usuario_preferencias.dart';
import 'package:serviciosconfirebase/src/bloc/provider.dart';

import 'package:serviciosconfirebase/src/pages/login_page.dart';
import 'package:serviciosconfirebase/src/pages/home_page.dart';
import 'package:serviciosconfirebase/src/pages/producto_page.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UsuariosPreferencias();
  await prefs.initPrefs();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = new UsuariosPreferencias();

    DefaultCacheManager().emptyCache();

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Validation',
        initialRoute: (prefs.token == '') ? LoginPage.routeName : prefs.ultimaPagina,
        routes: {
          LoginPage.routeName     : (BuildContext context) => LoginPage(),
          HomePage.routeName      : (BuildContext context) => HomePage(),
          ProductoPage.routeName  : (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
  }
}