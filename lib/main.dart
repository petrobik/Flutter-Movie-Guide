import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_guide/global.dart' as global;
import 'package:flutter_movie_guide/widgets/movies_list.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import 'models/movie.dart';
import 'movie_details.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Guide',
      theme: ThemeData(fontFamily: 'opensans', brightness: Brightness.dark),
//      theme: ThemeData.dark(),
      home: FlutterMoviesApp(),
    ));

class FlutterMoviesApp extends StatefulWidget {
  @override
  _FlutterMoviesApp createState() => new _FlutterMoviesApp();
}

class _FlutterMoviesApp extends State<FlutterMoviesApp> {
  Movie nowPlayingMovies;
  Movie upcomingMovies;
  Movie popularMovies;
  Movie topRatedMovies;

  @override
  void initState() {
    super.initState();
    _getNowPlayingMovies();
    _getUpcomingMovies();
    _getPopularMovies();
    _getTopRatedMovies();
  }

  void _getNowPlayingMovies() async {
    var response = await http.get(global.nowPlayingUrl);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      nowPlayingMovies = Movie.fromJson(decodeJson);
    });
  }

  void _getTopRatedMovies() async {
    var response = await http.get(global.topRatedUrl);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      topRatedMovies = Movie.fromJson(decodeJson);
    });
  }

  void _getUpcomingMovies() async {
    var response = await http.get(global.upcomingUrl);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      upcomingMovies = Movie.fromJson(decodeJson);
    });
  }

  void _getPopularMovies() async {
    var response = await http.get(global.popularUrl);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      popularMovies = Movie.fromJson(decodeJson);
    });
  }

  Widget _buildCarousel() => CarouselSlider(
        items: nowPlayingMovies == null
            ? <Widget>[Center(child: CircularProgressIndicator())]
            : nowPlayingMovies.results.map((movieItem) {
                return Builder(
                  builder: (BuildContext context) {
                    return Material(
                      elevation: 4.0,
                      color: Color.fromARGB(0, 18, 18, 18),
                      child: Container(
                        child: InkWell(
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              child: FadeInImage.memoryNetwork(
                                image: '${global.imagesUrl}w500${movieItem.posterPath}',
                                placeholder: kTransparentImage,
                                fit: BoxFit.cover,
                              )
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => MovieDetails(id: movieItem.id,)));
                          },
                        ),
                      )
                    );
                  },
                );
              }).toList(),
        autoPlay: false,
        height: 340.0,
        viewportFraction: 0.6,
        enlargeCenterPage: true,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Movie Guide',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
//        actions: <Widget>[
//          IconButton(icon: Icon(Icons.search), onPressed: () {}),
//        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 360,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                    child: popularMovies == null
                        ? Center(child: CircularProgressIndicator())
//                      : RandomMovie(popularMovies),
                        : _buildCarousel()
//                  ),
                    ),
              ),
            )
          ];
        },
        body: ListView(
          children: <Widget>[
            MoviesList(upcomingMovies, 'UPCOMING'),
            MoviesList(popularMovies, 'POPULAR'),
            MoviesList(topRatedMovies, 'TOP RATED'),
//            SizedBox(height: 4.0)
          ],
        ),
      ),
    );
  }
}
