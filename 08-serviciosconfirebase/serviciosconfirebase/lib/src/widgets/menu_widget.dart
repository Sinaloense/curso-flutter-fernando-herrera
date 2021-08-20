import 'package:flutter/material.dart';

import 'package:serviciosconfirebase/src/preferencias/usuario_preferencias.dart';
import 'package:serviciosconfirebase/src/bloc/provider.dart';

import 'package:serviciosconfirebase/src/pages/login_page.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new UsuariosPreferencias();
    final bloc = Provider.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/img/menu-img.jpg'),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.blue),
            title: Text('Cerrar sesión'),
            onTap: () {
              prefs.token = null;
              bloc.changeEmail('');
              bloc.changePassword('');
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            }
          ),
        ],
      ),
    );
  }
}