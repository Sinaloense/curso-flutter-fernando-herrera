import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:peliculas/src/models/peliculas_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({ @required this.peliculas, @required this.siguientePagina });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.30,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int i) => _tarjeta(context, peliculas[i]),
      ),
    );
  }

  // List<Widget> _tarjetas(BuildContext context) {
  //   final _screenSize = MediaQuery.of(context).size;

  //   return peliculas.map((pelicula) {
  //     return Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       child: Column(
  //         children: <Widget>[
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20.0),
  //             child: FadeInImage(
  //               image: NetworkImage(pelicula.getPosterImg()),
  //               placeholder: AssetImage('assets/img/no-image.jpg'),
  //               fit: BoxFit.cover,
  //               height: _screenSize.height * 0.25,
  //             ),
  //           ),
  //           SizedBox(height: 5.0),
  //           Text(
  //             pelicula.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final _screenSize = MediaQuery.of(context).size;

    pelicula.uniqueId = '${ pelicula.id }-movie_horizontal';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl: pelicula.getPosterImg(),
                placeholder: (context, url) => Image.asset(
                  'assets/img/no-image.jpg',
                  fit: BoxFit.cover,
                  height: _screenSize.height * 0.23
                  ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.23,
              ),
              
              // FadeInImage(
              //   image: NetworkImage(pelicula.getPosterImg()),
              //   placeholder: AssetImage('assets/img/no-image.jpg'),
              //   fit: BoxFit.cover,
              //   height: _screenSize.height * 0.23,
              // ),
            ),
          ),
          // SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}