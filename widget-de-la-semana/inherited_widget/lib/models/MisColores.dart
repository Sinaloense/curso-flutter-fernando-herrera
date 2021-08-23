import 'package:flutter/material.dart';

class MisColoresW extends InheritedWidget {
  MisColoresW({
    Key? key,
    required this.child,
    required this.color1,
    required this.color2,
  }) : super(key: key, child: child);

  final Widget child;
  final Color color1;
  final Color color2;

  static MisColoresW? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MisColoresW>();
  }

  @override
  bool updateShouldNotify(MisColoresW oldWidget) {
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }
}