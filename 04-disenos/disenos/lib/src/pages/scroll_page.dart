import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  final _controladorPagina = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controladorPagina,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _pagina1(),
          _pagina2(context),
        ],
      ),
    );
  }

  Widget _pagina1() {
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _imagenFondo(),
        _textos(),
      ],
    );
  }

  Widget _pagina2(BuildContext context) {
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _botonBienvenida(context),
      ],
    );
  }

  Widget _colorFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(80, 194, 221, 1.0),
    );
  }

  Widget _imagenFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/img/scroll-1.png'),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _textos() {
    final estiloTexto = TextStyle(color: Colors.white, fontSize: 50.0);

    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Text('11°', style: estiloTexto),
          Text('Miercoles', style: estiloTexto),
          Expanded(child: Container()),
          InkWell(
            onTap: () {
              _controladorPagina.animateToPage(
                1,
                curve: Curves.linear,
                duration: Duration(milliseconds: 300),
              );
            },
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 70.0,
              color: Colors.white
            )
          ),
        ],
      ),
    );
  }

  Widget _botonBienvenida(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: InkWell(
              onTap: () {
                _controladorPagina.animateToPage(
                0,
                curve: Curves.linear,
                duration: Duration(milliseconds: 300),
              );
              },
              child: Icon(
                Icons.keyboard_arrow_up,
                size: 70.0,
                color: Colors.white
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    child: Text(
                      'Bienvenidos',
                      style: TextStyle(fontSize: 20.0)
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'botones');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}