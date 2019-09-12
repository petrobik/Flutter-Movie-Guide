import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_guide/global.dart' as global;
import 'package:flutter_movie_guide/models/details.dart';
import 'package:flutter_movie_guide/widgets/actors_list.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import 'models/credits.dart';

class MovieDetails extends StatefulWidget {
//  final Result movie;
  final int id;

//  const MovieDetails({this.movie});
  const MovieDetails({this.id});

  @override
  _MovieDetails createState() => new _MovieDetails();
}

class _MovieDetails extends State<MovieDetails> {
  Details movieDetails;
  String detailsUrl;
  String creditsUrl;
  Genre genre;
  Credits credits;
  Cast cast;

  void _getMovieDetails() async {
    var response = await http.get(detailsUrl);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      movieDetails = Details.fromJson(decodeJson);
    });
  }

  void _getMovieCredits() async {
    var response = await http.get(creditsUrl);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      credits = Credits.fromJson(decodeJson);
    });
  }

  @override
  void initState() {
    super.initState();
    detailsUrl =
        '${global.baseUrl}${widget.id}?api_key=${global.apiKey}${global.language}';
    _getMovieDetails();
    creditsUrl =
        '${global.baseUrl}${widget.id}/credits?api_key=${global.apiKey}';
    _getMovieCredits();
  }

  String _getGenres(List<Genre> genres) {
    List genresString = [];
    for (genre in genres) genresString.add(genre.name);
    return genresString.join(', ');
  }

  String _getDuration(int minutes) {
    var duration = Duration(minutes: minutes);
    return '${duration.inHours}h ${duration.inMinutes.remainder(60)}min';
  }

  Widget _header() {
    return Text(
      // Header
      '${movieDetails.title} ${movieDetails.releaseDate == null ? '' :'(${movieDetails.releaseDate.year})'}',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _genresList() {
    return Container(
      height: 25.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[Text(_getGenres(movieDetails.genres))],
      ),
    );
  }

  Widget _durationRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          // Duration row
          children: <Widget>[
            Icon(Icons.access_time),
            SizedBox(
              width: 4.0,
            ),
            Text(movieDetails.runtime == null
                ? '--/--'
                : _getDuration(movieDetails.runtime)),
            SizedBox(
              width: 4.0,
            ),
          ],
        ),
        Row(
          // Rating row
          children: <Widget>[
            Text(movieDetails.voteAverage.toString()),
            SizedBox(
              width: 4.0,
            ),
            RatingBarIndicator(
              rating: movieDetails.voteAverage == 0
                  ? 0
                  : movieDetails.voteAverage / 2,
              itemBuilder: ((context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  )),
              itemCount: 5,
              itemSize: 24.0,
            ),
          ],
        )
      ],
    );
  }

  Widget _appBar(double barHeight) {
    return Container(
        height: barHeight * 1.1,
        child: movieDetails == null
            ? Center(child: CircularProgressIndicator())
            : Hero(
                tag: movieDetails.title,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 80.0)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: movieDetails.backdropPath == null
                        ? '${global.imagesUrl}w500${movieDetails.posterPath}'
                        : '${global.imagesUrl}w780${movieDetails.backdropPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ));
  }

  @override
  Widget build(BuildContext context) {
    var appbarHeight = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appbarHeight),
          child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.grey[850],
              flexibleSpace: _appBar(appbarHeight)),
        ),
        body: movieDetails == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _header(),
                    SizedBox(
                      height: 4.0,
                    ),
                    _genresList(),
                    _durationRatingRow(),
                    SizedBox(
                      height: 16.0,
                    ),
                    Flexible(
                      child: ListView(
                        children: <Widget>[
                          Text(movieDetails.overview),
                          SizedBox(height: 16.0),
                          Text(
                            'Cast',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          credits == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ActorsList(credits),
                          SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}