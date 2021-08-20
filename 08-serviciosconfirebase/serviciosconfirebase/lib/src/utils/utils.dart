import 'package:flutter/material.dart';

bool isValidEmail(String email) {
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if(regExp.hasMatch(email)) {
      return true;
    }
    else {
      return false;
    }
}

bool isValidPassword(String password) {
  if(password.length >= 6) {
      return true;
    }
    else {
      return false;
    }
}

bool isNumeric(String s) {
  if(s.isEmpty) {
    return false;
  }
  
  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  );
}