import 'package:shared_preferences/shared_preferences.dart';

import 'package:serviciosconfirebase/src/pages/login_page.dart';

class UsuariosPreferencias {
  // Singleton para que al referencias UsuariosPreferencias siempre regrese la misma instancia
  static final UsuariosPreferencias _instancia = new UsuariosPreferencias._internal();

  factory UsuariosPreferencias() {
    return _instancia;
  }

  UsuariosPreferencias._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimPagina') ?? LoginPage.routeName;
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimPagina', value);
  }
}