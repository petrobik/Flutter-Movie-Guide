import 'package:flutter/material.dart';
import 'package:flutter_movie_guide/global.dart' as global;
import 'package:flutter_movie_guide/models/movie.dart';
import 'package:flutter_movie_guide/movie_details.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesList extends StatelessWidget {
  final Movie movie;
  final String title;

  const MoviesList(this.movie, this.title);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 300,
        padding: EdgeInsets.only(
          top: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 6.0),
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Flexible(
                child: Container(
              child: ListView(
                padding: EdgeInsets.only(bottom: 4.0),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: movie == null
                    ? <Widget>[
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ]
                    : movie.results
                        .map((movieItem) => Padding(
                              padding: EdgeInsets.only(left: 1.0, right: 1.0),
                              child: _buildListItem(context, movieItem),
                            ))
                        .toList(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

Widget _buildListItem(BuildContext context, Result movieItem) {
  return Material(
//    elevation: 2.0,
//    color: Color.fromARGB(0, 18, 18, 18),
    child: Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 6.0, right: 6.0),
      width: 135,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 6.0),
            child: _buildMovieItem(context, movieItem),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 2.0, right: 4.0, bottom: 2.0, top: 2.0),
            child: Text(
              movieItem.title,
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMovieItem(BuildContext context, Result movieItem) {
  return Material(
      color: Color.fromARGB(0, 18, 18, 18),
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetails(
                        id: movieItem.id,
                      )));
        },
        child: Hero(
            tag: movieItem.title,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: '${global.imagesUrl}w500${movieItem.posterPath}',
                  height: 190.0,
                  fit: BoxFit.cover,
                ))),
      ));
}
