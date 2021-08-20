import 'package:flutter/material.dart';

class FondoCircular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Positioned(
          right: size.width * -0.7,
          top: size.height * -0.5,
          child: Container(
            width: size.width * 1.3,
            height: size.height * 1.0,
            decoration: BoxDecoration(
              color: Color.fromRGBO(239, 239, 239, 1.0),
              borderRadius: BorderRadius.circular(2000.0),
            ),
          ),
        ),
      ],
    );
  }
}