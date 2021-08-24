import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 400.0,
                color: Colors.blue,
                child: FittedBox(
                  fit: BoxFit.cover,
                  // alignment: Alignment.bottomCenter,
                  child: Image(
                    image: NetworkImage('https://wallpapercave.com/wp/wp2646303.jpg'),
                  ),
                ),
              ),

              // Divider(),

              // Image(
              //   image: NetworkImage('https://wallpapercave.com/wp/wp2646303.jpg'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}