import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData  _themeData;

  // Constructor (Asigna el parametro a _themeData)
  ThemeChanger(this._themeData);

  get themeData {
    return this._themeData;
  }

  set themeData(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}