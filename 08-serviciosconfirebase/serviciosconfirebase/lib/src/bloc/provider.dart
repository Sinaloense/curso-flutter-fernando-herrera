import 'package:flutter/material.dart';

import 'package:serviciosconfirebase/src/bloc/login_bloc.dart';
export 'package:serviciosconfirebase/src/bloc/login_bloc.dart';
import 'package:serviciosconfirebase/src/bloc/productos_bloc.dart';
export 'package:serviciosconfirebase/src/bloc/productos_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = new LoginBloc();
  final _productosBloc = new ProductosBloc();

  // Singleton
  static Provider _instancia;

  // La palabra factory es necesaria para Singleton
  factory Provider({ Key key, Widget child }) {
    // Si no existe la intancia, crearla, de lo contrario regresar la existente
    if(_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }

  // Mandarle como parametro el primer widget del arbol, ejemplo MaterialApp
  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child); // Llama al constructor de InheritedWidget

  // Mandarle como parametro el primer widget del arbol, ejemplo MaterialApp
  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context) {
    // Dentro del context viene un arbol de widgets de la aplicacion con la instancia de LoginBloc
    // Busca mediante un ciclo y regresa la primera o mas cercana instancia del Provider con el tipo loginBloc
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductosBloc productosBloc (BuildContext context) {
    // Dentro del context viene un arbol de widgets de la aplicacion con la instancia de LoginBloc
    // Busca mediante un ciclo y regresa la primera o mas cercana instancia del Provider con el tipo loginBloc
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productosBloc;
  }
}