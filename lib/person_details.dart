import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie_guide/global.dart' as global;
import 'package:intl/intl.dart';
import 'models/person.dart';
import 'package:transparent_image/transparent_image.dart';

import 'models/person_movies.dart';
import 'movie_details.dart';

class PersonDetails extends StatefulWidget {
  final int id;

  const PersonDetails({this.id});

  @override
  _PersonDetails createState() => new _PersonDetails();
}

class _PersonDetails extends State<PersonDetails> {
  String personUrl;
  String moviesUrl;
  Person person;
  PersonMovies movieCredits;
//  Movie movie;

  _getPersonDetails() async {
    var response = await http.get(personUrl);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      person = Person.fromJson(decodeJson);
    });
  }

  _getPersonMovies() async {
    var response = await http.get(moviesUrl);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      movieCredits = PersonMovies.fromJson(decodeJson);
    });
  }

  @override
  void initState() {
    super.initState();
    personUrl =
        '${global.personUrl}${widget.id}?api_key=${global.apiKey}${global.language}';
    moviesUrl =
        '${global.personUrl}${widget.id}/movie_credits?api_key=${global.apiKey}${global.language}';
    _getPersonDetails();
    _getPersonMovies();
  }

  Widget _appBar() {
    return Container(
        child: person == null
            ? Center(child: CircularProgressIndicator())
            : Hero(
                tag: person.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 80.0)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${global.imagesUrl}w500${person.profilePath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ));
  }

  Widget _moviesList() {
    return Container(
      height: 190.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (Movie movie
              in movieCredits.movies.where((movie) => movie.voteCount > 500))
            Padding(
                padding: EdgeInsets.only(right: 4.0, left: 4.0),
                child: Container(
                  width: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDetails(
                                        id: movie.id,
                                      )));
                        },
                        child: Hero(
                          tag: movie.id,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: movie.posterPath == null
                                ? Image(
                                    image:
                                        AssetImage('assets/images/actor.png'),
                                    fit: BoxFit.cover,
                                    height: 140,
                                    colorBlendMode: BlendMode.overlay,
                                  )
                                : FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image:
                                        '${global.imagesUrl}w185${movie.posterPath}',
                                    fit: BoxFit.cover,
//                                                          width: 80.0,
                                    height: 140.0,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 4.0, right: 6.0),
                          child: Text(
                            movie.title,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ))
                    ],
                  ),
                ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height * 0.5;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size),
          child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.grey[850],
              flexibleSpace: _appBar()),
        ),
        body: person == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      person.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Flexible(
                      child: ListView(
                        children: <Widget>[
                          Text(
                            'Birthday: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(person.birthday == null
                              ? '-'
                              : DateFormat.yMMMd().format(person.birthday)),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'Place of Birth: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            person.placeOfBirth == null
                                ? '-'
                                : person.placeOfBirth,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          ExpandablePanel(
                            header: Text(
                              'Biography',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            collapsed: Text(
                              person.biography,
                              maxLines: 5,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            expanded: Text(
                              person.biography,
                              softWrap: true,
                            ),
                            tapHeaderToExpand: true,
                            tapBodyToCollapse: true,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'Known For',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          movieCredits == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _moviesList(),
                          SizedBox(
                            height: 8.0,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
