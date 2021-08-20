import 'package:flutter/material.dart';

import 'package:componentes/src/providers/menu_provider.dart';
import 'package:componentes/src/utils/icon_string_util.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    print(myLocale.languageCode); // Idioma del dispositivo

    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    // menuProvider.cargarData().then((opciones) {
    //   print('_lista');
    //   print(opciones);
    // });

    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(context, snapshot.data)
        );
      },
    );
  }

  List<Widget> _listaItems(BuildContext context, List<dynamic> data) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          // final route = MaterialPageRoute(
          //   builder: (context) => AlertPage()
          // );

          // Navigator.push(context, route);
          
          Navigator.pushNamed(context, opt['ruta']);
        }
      );

      opciones..add(widgetTemp)
        ..add(Divider());
    });

    return opciones;
  }
}