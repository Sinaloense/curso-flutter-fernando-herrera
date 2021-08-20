import 'dart:async';

import 'package:formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  // Stream tipo broadcast para poder escuchar a multiples instancias
  // final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();

  // BehaviorSubject son los Streams de rxdart
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
  
  // Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
    CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

}