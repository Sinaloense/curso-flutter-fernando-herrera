import 'package:shared_preferences/shared_preferences.dart';

import 'package:preferenciasusuariosapp/src/pages/home_page.dart';

class PreferenciasUsuario {
  // Singleton para que al referencias PreferenciasUsuario siempre regrese la misma instancia
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del genero
  get genero {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }

  // GET y SET del colorSecundario
  get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('colorSecundario', value);
  }

  // GET y SET del nombreUsuario
  get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
  }

  // GET y SET de la última página
  get ultimPagina {
    return _prefs.getString('ultimPagina') ?? HomePage.routeName;
  }

  set ultimPagina(String value) {
    _prefs.setString('ultimPagina', value);
  }
}