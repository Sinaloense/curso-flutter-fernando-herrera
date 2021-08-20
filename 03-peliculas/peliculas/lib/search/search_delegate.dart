import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:peliculas/screens/screens.dart';

import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/models/models.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _MovieList(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _MovieList(query: query);
  }
}

class _MovieList extends StatelessWidget {
  final String query;

  const _MovieList({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    // Llamar stream
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if(!snapshot.hasData) {
          return _emptyContainer();
        }

        final movies = snapshot.data!;
        final size = MediaQuery.of(context).size;

        return ListView.builder(
          key: PageStorageKey('listSearch'),
          itemCount: movies.length,
          itemBuilder: (_, int i) => _MovieItem(movie: movies[i], size: size),
        );
      },
    );
  }

  Widget _emptyContainer() {
    return Container(
        child: Center(
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 130,
          ),
        )
      );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Size size;

  const _MovieItem({
    Key? key,
    required this.movie,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${ movie.id }';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'), 
          image: NetworkImage(movie.fullPosterImg),
          width: size.width * 0.2,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName, arguments: movie);
      },
    );
  }
}