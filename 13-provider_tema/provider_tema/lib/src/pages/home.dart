import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:provider_tema/src/blocs/theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar'),
      ),
      body: listaBotones(theme),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => theme.themeData = ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lime,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.lime,
          ),
        )
      ),
    );
  }

  Widget listaBotones(ThemeChanger theme) {
    return Column(
      children: <Widget>[
        FlatButton(
          child: Text('Light'),
          onPressed: () => theme.themeData = ThemeData.light(),
        ),
        FlatButton(
          child: Text('Dark'),
          onPressed: () => theme.themeData = ThemeData.dark(),
        ),
      ],
    );
  }
}