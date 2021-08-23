import 'dart:async';

import 'package:flutter/material.dart';
 
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
  final colorStream = new StreamController<Color>();

  int counter = -1;
  final List<Color> colorList = [
    Colors.blue,
    Colors.yellowAccent,
    Colors.green,
  ];

  @override
  void dispose() {
    colorStream.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: colorStream.stream,
          // initialData: initialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(!snapshot.hasData) {
              return _LoadingWidget();
            }

            if(snapshot.connectionState == ConnectionState.done) {
              return Text('Fin del Stream :(');
            }

            return Container(
              height: 150,
              width: 150,
              color: snapshot.data,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.color_lens),
        onPressed: () {
          counter++;

          if(counter < colorList.length) {
            colorStream.sink.add(colorList[counter]);
          }
          else {
            colorStream.close();
          }
        },
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Esperando clicks'),
        SizedBox(height: 20),
        CircularProgressIndicator(),
      ],
    );
  }
}