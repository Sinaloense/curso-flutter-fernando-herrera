import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Tooltip(
          message: 'Este es el mejor botón del mundo',
          preferBelow: false,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(StadiumBorder())
            ),
            child: Text(
              'Hola mundo',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {},
          ),
        )
      ),
    );
  }
}