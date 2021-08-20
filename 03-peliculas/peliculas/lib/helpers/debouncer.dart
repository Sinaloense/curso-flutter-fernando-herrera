// https://gist.github.com/Klerith/62b00635acec3614d2b35c066df724e6

// Creditos
// https://stackoverflow.com/a/52922130/7834829

/*
  Clase para llamar función "onValue" mediante un timer
  cada vez que "value" sea modificado.
*/

import 'dart:async';

class Debouncer<T> {

  Debouncer({ 
    required this.duration, 
    this.onValue 
  });

  final Duration duration;

  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;
  
  T get value => _value!;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value!));
  }  
}