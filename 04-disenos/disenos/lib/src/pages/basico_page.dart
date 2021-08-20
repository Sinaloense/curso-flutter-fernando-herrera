import 'package:flutter/material.dart';

import 'package:transparent_image/transparent_image.dart';

class BasicoPage extends StatelessWidget {
  final _estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final _estiloSubTitulo = TextStyle(fontSize: 16.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _crearImagen(screenSize),
              _crearTitulo(),
              _crearAcciones(context),
              _crearTexto(),
              _crearTexto(),
              _crearTexto(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearImagen(Size screenSize) {
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.4,
      child: Stack(
        children: <Widget>[
          Center(child: CircularProgressIndicator()),
          Center(
            child: FadeInImage.memoryNetwork(
              image: 'https://images.pexels.com/photos/814499/pexels-photo-814499.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              placeholder: kTransparentImage,
              width: double.infinity,
              height: screenSize.height * 0.4,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lago con un puente', style: _estiloTitulo),
                  SizedBox(height: 7.0),
                  Text('Un lago en Alemania', style: _estiloSubTitulo),
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red,
              size: 30.0,
            ),
            Text(
              '41',
              style: TextStyle(fontSize: 20.0)
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _accion(context, Icons.call, 'CALL'),
        _accion(context, Icons.near_me, 'ROUTE'),
        _accion(context, Icons.share, 'SHARE'),
      ],
    );
  }

  Widget _accion(BuildContext context, IconData icono, String texto) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: () {
        Navigator.pushNamed(context, 'scroll');
      },
      child: Container(
        width: 70.0,
        child: Column(
          children: <Widget>[
            Icon(
              icono,
              color: Colors.blue,
              size: 40.0,
            ),
            SizedBox(height: 5.0),
            Text(
              texto,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
          'Sunt enim deserunt dolor enim ut occaecat. Officia nostrud quis sit voluptate nulla consequat adipisicing veniam. Do ut cillum veniam elit qui duis eiusmod do dolore dolor ullamco. Culpa quis dolor officia laborum quis deserunt occaecat Lorem cillum.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}