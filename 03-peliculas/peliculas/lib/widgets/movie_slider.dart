import 'package:flutter/material.dart';

import 'package:peliculas/models/models.dart';
import 'package:peliculas/screens/screens.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final Function onNextPage;
  final String? title;

  const MovieSlider({
    Key? key,
    required this.movies,
    required this.onNextPage,
    this.title,
  }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = new ScrollController();
  
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260.0,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: widget.title == null ? null : Text(
                widget.title!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int i) => _MoviePoster(movie: widget.movies[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'slider-${ movie.id }';

    return Center(
      child: Container(
        width: 130.0,
        height: 220.0,
        // color: Colors.green,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context, DetailsScreen.routeName,
                arguments: movie,
              ),
              child: Hero(
                tag: movie.heroId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImg),
                    width: 130.0,
                    height: 190.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: 5),

            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}