import 'package:flutter/material.dart';

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';

class ListaPage extends StatefulWidget {
  ListaPage({Key key}) : super(key: key);

  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  ScrollController _scrollController = new ScrollController();

  List<int> _listaNumeros = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;

  // Este codigo se puede poner en el Widget build, pero es para conocer esta función initState
  @override
  void initState() {
    super.initState();

    _agregar10();

    _scrollController.addListener(() {
      // Si estamos al final del scroll
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        //_agregar10();
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Liberar memoria
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Stack(
        children: <Widget>[
          _crearLista(),
          _crearLoading(),
        ],
      ),
    );
  }

  Widget _crearLista() {
    return RefreshIndicator(
        onRefresh: _obtenerPagina1,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _listaNumeros.length,
          itemBuilder: (BuildContext context, int index) {
            final imagen = _listaNumeros[index];

            return CachedNetworkImage(
              imageUrl: 'https://i.picsum.photos/id/$imagen/500/300.jpg',
              placeholder: (context, url) => Image.asset('assets/jar-loading.gif'),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
              height: 250.0,
              //width: 500.0,
            );
            
            // FadeInImage(
            //   image: NetworkImage('https://i.picsum.photos/id/$imagen/500/300.jpg'),
            //   placeholder: AssetImage('assets/jar-loading.gif'),
            //   fit: BoxFit.fill,
            //   height: 250.0,
            //   //width: 500.0,
            // );
          },
        ),
    );
  }

  Future<Null> _obtenerPagina1() async {
    final duration = new Duration(seconds: 2);
    
    new Timer(duration, () {
      _listaNumeros.clear();
      _agregar10();
    });

    return Future.delayed(duration);
  }

  void _agregar10() {
    for (var i = 0; i < 10; i++) {
      _ultimoItem++;
      _listaNumeros.add(_ultimoItem);
    }

    if (this.mounted == false)
      return;

    setState(() {
      
    });
  }

  Future<Null> fetchData() async {
    _isLoading = true;

    if (this.mounted == false)
      return;

    setState(() {
      
    });

    final duration = new Duration(seconds: 2);

    new Timer(duration, respuestaHTTP);

    return null;
  }

  void respuestaHTTP() {
    _isLoading = false;

    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 250)
    );

    _agregar10();
  }

  Widget _crearLoading() {
    if(_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(height: 15.0),
        ],
      );
    }
    else {
      return Container();
    }
  }
}