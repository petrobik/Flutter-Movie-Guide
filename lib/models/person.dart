// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);

import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  DateTime birthday;
  String knownForDepartment;
  dynamic deathday;
  int id;
  String name;
  List<String> alsoKnownAs;
  int gender;
  String biography;
  double popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbId;
  dynamic homepage;

  Person({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    knownForDepartment: json["known_for_department"],
    deathday: json["deathday"],
    id: json["id"],
    name: json["name"],
    alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
    gender: json["gender"],
    biography: json["biography"],
    popularity: json["popularity"].toDouble(),
    placeOfBirth: json["place_of_birth"],
    profilePath: json["profile_path"],
    adult: json["adult"],
    imdbId: json["imdb_id"],
    homepage: json["homepage"],
  );

  Map<String, dynamic> toJson() => {
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "known_for_department": knownForDepartment,
    "deathday": deathday,
    "id": id,
    "name": name,
    "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
    "gender": gender,
    "biography": biography,
    "popularity": popularity,
    "place_of_birth": placeOfBirth,
    "profile_path": profilePath,
    "adult": adult,
    "imdb_id": imdbId,
    "homepage": homepage,
  };
}
