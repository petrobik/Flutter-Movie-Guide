// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));

String movieToJson(Movie data) => json.encode(data.toJson());

class Movie {
  List<Result> results;
  int page;
  int totalResults;
//  Dates dates;
  int totalPages;

  Movie({
    this.results,
    this.page,
    this.totalResults,
//    this.dates,
    this.totalPages,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => new Movie(
        results: new List<Result>.from(
            json["results"].map((x) => Result.fromJson(x))),
        page: json["page"],
        totalResults: json["total_results"],
//    dates: Dates.fromJson(json["dates"]),
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "results": new List<dynamic>.from(results.map((x) => x.toJson())),
        "page": page,
        "total_results": totalResults,
//    "dates": dates.toJson(),
        "total_pages": totalPages,
      };
}

//class Dates {
//  DateTime maximum;
//  DateTime minimum;
//
//  Dates({
//    this.maximum,
//    this.minimum,
//  });
//
//  factory Dates.fromJson(Map<String, dynamic> json) => new Dates(
//    maximum: DateTime.parse(json["maximum"]),
//    minimum: DateTime.parse(json["minimum"]),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
//    "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
//  };
//}

class Result {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  DateTime releaseDate;

  Result({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
        popularity: json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        posterPath: json["poster_path"],
        id: json["id"],
        adult: json["adult"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        genreIds: new List<int>.from(json["genre_ids"].map((x) => x)),
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
      );

  Map<String, dynamic> toJson() => {
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "poster_path": posterPath,
        "id": id,
        "adult": adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "genre_ids": new List<dynamic>.from(genreIds.map((x) => x)),
        "title": title,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
      };
}
