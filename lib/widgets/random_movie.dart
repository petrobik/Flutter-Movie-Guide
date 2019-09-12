import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_movie_guide/global.dart' as global;
import 'package:flutter_movie_guide/models/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class RandomMovie extends StatelessWidget {
  final Movie movie;

  const RandomMovie(this.movie);

  @override
  Widget build(BuildContext context) {
    final _random = Random();
    var element = movie.results[_random.nextInt(movie.results.length)];

    return Material(
      elevation: 4.0,
      child: InkWell(
//        onTap: () {
//          Navigator.push(context, MaterialPageRoute(
//              builder: (context) => MovieDetails(movie: element,)));
//        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: element.backdropPath == null
                      ? '${global.imagesUrl}w500${element.posterPath}'
                      : '${global.imagesUrl}w780${element.backdropPath}',
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                bottom: 16.0,
                left: 16.0,
                right: 8.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${element.title}',
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          shadows: <Shadow>[
                            Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black38),
                            Shadow(
                                offset: Offset(-2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black38),
                            Shadow(
                                offset: Offset(2.0, -2.0),
                                blurRadius: 3.0,
                                color: Colors.black38)
                          ]),
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: <Widget>[
                        Material(
                          child: Icon(Icons.star),
                          elevation: 8.0,
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
//                          DateFormat.yMMMd().format(element.releaseDate),
                          '${element.voteAverage}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Colors.black38),
                                Shadow(
                                    offset: Offset(-2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Colors.black38),
                                Shadow(
                                    offset: Offset(2.0, -2.0),
                                    blurRadius: 3.0,
                                    color: Colors.black38)
                              ]),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
