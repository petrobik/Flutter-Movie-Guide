// To parse this JSON data, do
//
//     final personMovies = personMoviesFromJson(jsonString);

import 'dart:convert';

PersonMovies personMoviesFromJson(String str) => PersonMovies.fromJson(json.decode(str));

String personMoviesToJson(PersonMovies data) => json.encode(data.toJson());

class PersonMovies {
  List<Movie> movies;
  List<dynamic> crew;
  int id;

  PersonMovies({
    this.movies,
    this.crew,
    this.id,
  });

  factory PersonMovies.fromJson(Map<String, dynamic> json) => PersonMovies(
    movies: List<Movie>.from(json["cast"].map((x) => Movie.fromJson(x))),
    crew: List<dynamic>.from(json["crew"].map((x) => x)),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "cast": List<dynamic>.from(movies.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x)),
    "id": id,
  };
}

class Movie {
  String character;
  String creditId;
  String posterPath;
  int id;
  bool video;
  int voteCount;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  String originalLanguage;
  String originalTitle;
  double popularity;
  String title;
  double voteAverage;
  String overview;
//  DateTime releaseDate;

  Movie({
    this.character,
    this.creditId,
    this.posterPath,
    this.id,
    this.video,
    this.voteCount,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.popularity,
    this.title,
    this.voteAverage,
    this.overview,
//    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    character: json["character"],
    creditId: json["credit_id"],
    posterPath: json["poster_path"],
    id: json["id"],
    video: json["video"],
    voteCount: json["vote_count"],
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    popularity: json["popularity"].toDouble(),
    title: json["title"],
    voteAverage: json["vote_average"].toDouble(),
    overview: json["overview"],
//    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
  );

  Map<String, dynamic> toJson() => {
    "character": character,
    "credit_id": creditId,
    "poster_path": posterPath,
    "id": id,
    "video": video,
    "vote_count": voteCount,
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "popularity": popularity,
    "title": title,
    "vote_average": voteAverage,
    "overview": overview,
//    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
  };
}
