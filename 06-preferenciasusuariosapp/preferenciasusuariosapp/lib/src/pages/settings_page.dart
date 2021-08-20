import 'package:flutter/material.dart';

import 'package:preferenciasusuariosapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasusuariosapp/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSecundario;
  int _genero;
  String _nombreUsuario;

  TextEditingController _textCtrl;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();

    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _nombreUsuario = prefs.nombreUsuario;

    _textCtrl = new TextEditingController(text: _nombreUsuario);
  }

  _setSelectedRadio(int valor) {
    prefs.genero = valor;
    _genero = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimPagina = SettingsPage.routeName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold)),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            onChanged: (bool value) {
              setState(() {
                prefs.colorSecundario = value;
                _colorSecundario = value;
              });
            },
            title: Text('Color secundario'),
          ),
          RadioListTile(
            value: 1,
            groupValue: _genero,
            onChanged: (int value) => _setSelectedRadio(value),
            title: Text('Masculino'),
          ),
          RadioListTile(
            value: 2,
            groupValue: _genero,
            onChanged: (int value) => _setSelectedRadio(value),
            title: Text('Femenino'),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textCtrl,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el teléfono',
              ),
              onChanged: (String value) {
                prefs.nombreUsuario = value;
                _nombreUsuario = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}