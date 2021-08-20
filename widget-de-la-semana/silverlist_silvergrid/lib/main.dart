import 'dart:math';

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

class _MiPagina extends StatelessWidget {
  const _MiPagina({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = List.generate(200, (i) => Rectangulo(index: i));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: Text('SliverGrid'),
          ),

          // Limitar por numero de items
          // SliverGrid.count(
          //   crossAxisCount: 7,
          //   children: items,
          // ),
          // Limitar por pixeles
          SliverGrid.extent(
            maxCrossAxisExtent: 100,
            children: items,
          ),

          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: Text('SliverList'),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int i) {
                return items[i];
              },
              childCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}

class Rectangulo extends StatelessWidget {
  final int index;

  const Rectangulo({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rnd = new Random();
    final r = rnd.nextInt(255);
    final g = rnd.nextInt(255);
    final b = rnd.nextInt(255);

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Color.fromRGBO(r, g, b, 1.0),
      ),
      child: Center(
        child: Text(
          '$index',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}