import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serviciosconfirebase/src/preferencias/usuario_preferencias.dart';

class UsuarioProvider {
  final String _firebaseKey = 'AIzaSyD31PcxykyDZ_W53CR75j9yftoVkfTuVFY';
  final _prefs = new UsuariosPreferencias();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseKey',
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];

      return {
        'ok' : true,
        'token' : decodedResp['idToken']
      };
    }
    else {
      return {
        'ok'        : false,
        'mensaje'   : decodedResp['error']['message'],
      };
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async {
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseKey',
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      
      return {
        'ok' : true,
        'token' : decodedResp['idToken']
      };
    }
    else {
      return {
        'ok'        : false,
        'mensaje'   : decodedResp['error']['message'],
      };
    }
  }
}