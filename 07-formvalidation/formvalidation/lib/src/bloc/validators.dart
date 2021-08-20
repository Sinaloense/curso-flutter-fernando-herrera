import 'dart:async';

// abstract, palabra para que no se puedan crear instancias de la clase
abstract class Validators {
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (String email, EventSink<String> sink) {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)) {
        sink.add(email);
      }
      else {
        sink.addError('Email no es correcto');
      }

    }
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (String password, EventSink<String> sink) {
      if(password.length >= 6) {
        sink.add(password);
      }
      else {
        sink.addError('Más de 6 caracteres por favor');
      }
    }
  );
}