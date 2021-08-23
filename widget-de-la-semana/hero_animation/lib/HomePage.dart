import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero_animation/DetailPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void pushRoute(BuildContext context) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (BuildContext context) => DetailPage()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Animation'),
      ),
      body: SingleChildScrollView(
        child: Table(
          children: [
            TableRow(
              children: [
                Placeholder(fallbackHeight: 150.0),
                Placeholder(fallbackHeight: 150.0),
                Placeholder(fallbackHeight: 150.0),
              ]
            ),
            TableRow(
              children: [
                Placeholder(fallbackHeight: 150.0),
                Placeholder(fallbackHeight: 150.0),
                Placeholder(fallbackHeight: 150.0),
              ]
            ),
            TableRow(
              children: [
                GestureDetector(
                  child: Hero(
                    tag: 'logo',
                    child: FlutterLogo(size: 150.0),
                  ),
                  onTap: () => pushRoute(context),
                ),
                Placeholder(fallbackHeight: 150.0),
                Placeholder(fallbackHeight: 150.0),
              ]
            ),
            TableRow(
              children: [
                Placeholder(fallbackHeight: 150.0),
                Placeholder(fallbackHeight: 150.0),
                Container(),
              ]
            ),
          ],
        ),
      ),
    );
  }
}