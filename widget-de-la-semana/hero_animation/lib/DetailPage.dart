import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'logo',
              child: FlutterLogo(size: 450.0),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                'Nisi nisi do ex ut ea qui culpa nisi ea excepteur.',
                style: TextStyle(fontSize: 30.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}