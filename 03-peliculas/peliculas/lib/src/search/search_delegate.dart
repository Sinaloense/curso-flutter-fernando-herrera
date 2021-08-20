import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:peliculas/src/models/peliculas_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  // String seleccion = '';
  
  // final peliculas = [
  //   'SpiderMan',
  //   'AquaMan',
  //   'Batman',
  //   'Shazam!',
  //   'Iron Man',
  //   'Iron Man 2',
  //   'Iron Man 3',
  //   'Iron Man 4',
  //   'Iron Man 5',
  //   'Capitan America',
  //   'SuperMan'
  // ];

  // final peliculasRecientes = [
  //   'SpiderMan',
  //   'Capitan America',
  // ];

  final PeliculasProvider peliculasProvider = new PeliculasProvider();
  BuildContext ultimoContext;
  String ultimoQuery = '';
  ListView listaResultados = ListView();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return listaResultados;
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   final listaSugerida = (query.isEmpty)
  //     ? peliculasRecientes
  //     : peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

  //   // Son las sugerencias que aparecen cuando la persona escribe
  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (BuildContext context, int i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: () {
  //           seleccion = listaSugerida[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _mostrarResultados(context);
  }

  Widget _mostrarResultados(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if(query.isEmpty) {
      return Container();
    }
    else if(query == ultimoQuery) {
      return listaResultados;
    }

    ultimoContext = context;
    
    final _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData) {
          final peliculas = snapshot.data;

          ultimoQuery = query;
          listaResultados = ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: pelicula.getPosterImg(),
                  placeholder: (context, url) => Image.asset(
                    'assets/img/no-image.jpg',
                    fit: BoxFit.cover,
                    width: _screenSize.width * 0.2,
                    // height: _screenSize.height * 0.1,
                    ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: _screenSize.width * 0.2,
                  // height: _screenSize.height * 0.1,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(ultimoContext, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(ultimoContext, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );

          return listaResultados;
        }
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}