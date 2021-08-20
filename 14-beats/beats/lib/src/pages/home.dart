import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:beats/src/widgets/fondo_circular.dart';
import 'package:beats/src/widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  final route = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FondoCircular(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomAppBar(),
                  _Header(),
                ],
              ),
            ),
          ),
          BuyButton(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: size.height * 0.05),
          Text('Beats', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
          Text('By Dre', style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18.0)),
        ],
      ),
    );
  }
}

class BuyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(
            width: size.width * 0.3,
            height: size.height * 0.12,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 20.0),
                Text('Buy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
                SizedBox(width: 5.0),
                Icon(FontAwesomeIcons.arrowRight, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}