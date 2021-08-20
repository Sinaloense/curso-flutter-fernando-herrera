import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:peliculas/src/models/peliculas_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 3.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.4,
        itemBuilder: (BuildContext context,int index) {
          peliculas[index].uniqueId = '${ peliculas[index].id }-card_swiper';

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                child: CachedNetworkImage(
                  imageUrl: peliculas[index].getPosterImg(),
                  placeholder: (context, url) => Image.asset(
                    'assets/img/no-image.jpg',
                    fit: BoxFit.cover,
                    ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover
                ),
              ),
              
              // FadeInImage(
              //   image: NetworkImage(peliculas[index].getPosterImg()),
              //   placeholder: AssetImage('assets/img/no-image.jpg'),
              //   fit: BoxFit.cover,
              // ),
            ),
          );
        },
        itemCount: peliculas.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}