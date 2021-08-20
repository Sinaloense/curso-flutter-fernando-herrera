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
          _Pagina1(controladorPagina: _controladorPagina),
          _Pagina2(controladorPagina: _controladorPagina, context: context),
        ],
      ),
    );
  }
}

class _Pagina1 extends StatelessWidget {
  const _Pagina1({
    Key? key,
    required this.controladorPagina,
  }) : super(key: key);

  final PageController controladorPagina;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _ColorFondo(),
        _ImagenFondo(),
        _Textos(controladorPagina: controladorPagina),
      ],
    );
  }
}

class _Pagina2 extends StatelessWidget {
  const _Pagina2({
    Key? key,
    required this.controladorPagina,
    required this.context,
  }) : super(key: key);

  final PageController controladorPagina;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _ColorFondo(),
        _BotonBienvenida(controladorPagina: controladorPagina, context: context),
      ],
    );
  }
}

class _ColorFondo extends StatelessWidget {
  const _ColorFondo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(80, 194, 221, 1.0),
    );
  }
}

class _ImagenFondo extends StatelessWidget {
  const _ImagenFondo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/img/scroll-1.png'),
        fit: BoxFit.fill,
      ),
    );
  }
}

class _Textos extends StatelessWidget {
  const _Textos({
    Key? key,
    required this.controladorPagina,
  }) :  super(key: key);

  final PageController controladorPagina;

  @override
  Widget build(BuildContext context) {
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
              controladorPagina.animateToPage(
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
}

class _BotonBienvenida extends StatelessWidget {
  const _BotonBienvenida({
    Key? key,
    required this.controladorPagina,
    required this.context,
  }) : super(key: key);

  final PageController controladorPagina;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: InkWell(
              onTap: () {
                controladorPagina.animateToPage(
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
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