import 'package:flutter/material.dart';

import 'package:inherited_widget/models/MisColores.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: _MiPagina(),
    );
  }
}

class _MiPagina extends StatefulWidget {
  const _MiPagina({
    Key? key,
  }) : super(key: key);

  @override
  __MiPaginaState createState() => __MiPaginaState();
}

class __MiPaginaState extends State<_MiPagina> {
  Color color1 = Colors.redAccent;
  Color color2 = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return MisColoresW(
      color1: color1,
      color2: color2,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Rectangulo1(),
              Rectangulo2(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.contacts),
          onPressed: () {
            setState(() {
              color1 = Colors.pink;
              color1 = Colors.purple;
            });
          },
        ),
      ),
    );
  }
}

class Rectangulo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final misColoresW = context.dependOnInheritedWidgetOfExactType<MisColoresW>()!;

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: misColoresW.color1,
      ),
    ); 
  }
}

class Rectangulo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final misColoresW = context.dependOnInheritedWidgetOfExactType<MisColoresW>()!;

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: misColoresW.color2,
      ),
    ); 
  }
}