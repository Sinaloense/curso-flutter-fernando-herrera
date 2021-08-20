import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/models/models.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({
    Key? key,
    required this.movieId,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if(!snapshot.hasData) {
          return Container(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 270.0,
          // color: Colors.red,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int i) => _CastCard(actor: cast[i]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 130.0,
        height: 230.0,
        // color: Colors.green,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(actor.fullProfilePath),
                width: 130.0,
                height: 190.0,
                fit: BoxFit.cover,
              ),
            ),

            Text(
              actor.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}