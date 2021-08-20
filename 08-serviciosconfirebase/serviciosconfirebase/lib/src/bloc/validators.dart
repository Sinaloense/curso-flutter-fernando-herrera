import 'dart:async';

import 'package:serviciosconfirebase/src/utils/utils.dart';

// abstract, palabra para que no se puedan crear instancias de la clase
abstract class Validators {
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (String email, EventSink<String> sink) {
      if(isValidEmail(email) || email.length == 0) {
        sink.add(email);
      }
      else {
        sink.addError('Email no es correcto');
      }
    }
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (String password, EventSink<String> sink) {
      if(isValidPassword(password) || password.length == 0) {
        sink.add(password);
      }
      else {
        sink.addError('Más de 6 caracteres por favor');
      }
    }
  );
}