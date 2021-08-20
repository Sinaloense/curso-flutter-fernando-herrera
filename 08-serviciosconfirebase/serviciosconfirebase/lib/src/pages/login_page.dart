import 'package:flutter/material.dart';

import 'package:serviciosconfirebase/src/bloc/provider.dart';
import 'package:serviciosconfirebase/src/providers/usuario_provider.dart';
import 'package:serviciosconfirebase/src/utils/utils.dart';
import 'package:serviciosconfirebase/src/preferencias/usuario_preferencias.dart';

import 'package:serviciosconfirebase/src/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = '_login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioProvider = UsuarioProvider();

  bool _pantallaLogin = true;

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final ScrollController _formCtrl = ScrollController();

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final prefs = new UsuariosPreferencias();
    prefs.ultimaPagina = HomePage.routeName;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ]
        ),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          height: size.height * 0.4,
          child: Column(
            children: <Widget>[
              Expanded(child: Container()),
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0),
              Text('Fernando Herrera', style: TextStyle(color: Colors.white, fontSize: 25.0)),
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      controller: _formCtrl,
      child: Column(
        children: <Widget>[
          OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              double safeAreaHeight = size.height * 0.37;

              if(orientation == Orientation.portrait) {
                safeAreaHeight = size.height * 0.32;
              }

              return SafeArea(
                child: Container(
                  height: safeAreaHeight
                ),
              );
            },
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.only(bottom: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(_pantallaLogin ? 'Ingreso' : 'Registro', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc),
                SizedBox(height: 30.0),
                FlatButton(
                  child: Text(_pantallaLogin ? 'Crear una nueva cuenta' : '¿Ya tienes una cuenta?'),
                    onPressed: () {
                      _emailCtrl.clear();
                      _passwordCtrl.clear();
                      bloc.changeEmail('');
                      bloc.changePassword('');
                      
                      FocusScope.of(context).unfocus();

                      _formCtrl.animateTo(
                        0.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );

                      setState(() {
                          _pantallaLogin = !_pantallaLogin;
                      });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSubmitted: (String value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: (String value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            focusNode: _passwordFocusNode,
            controller: _passwordCtrl,
            obscureText: true,
            textInputAction: TextInputAction.go,
            onSubmitted: (String value) {
              FocusScope.of(context).unfocus();

              if(!isValidEmail(bloc.email) || !isValidPassword(bloc.password)) {
                return;
              }

              if(_pantallaLogin == true) {
                return _login(context, bloc);
              }
              else {
                return _register(context, bloc);
              }
            },
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.deepPurple),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(_pantallaLogin ? 'Ingresar' : 'Registarse'),
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: !snapshot.hasData ? null : () {
            if(_pantallaLogin == true) {
              return _login(context, bloc);
            }
            else {
              return _register(context, bloc);
            }
          },
        );
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc) async {
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if(info['ok']) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
    else {
      mostrarAlerta(context, info['mensaje']);
    }
  }

  _register(BuildContext context, LoginBloc bloc) async {
    Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

    if(info['ok']) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
    else {
      mostrarAlerta(context, info['mensaje']);
    }
  }
}