// To parse this JSON data, do
//
//     final credits = creditsFromJson(jsonString);

import 'dart:convert';

Credits creditsFromJson(String str) => Credits.fromJson(json.decode(str));

String creditsToJson(Credits data) => json.encode(data.toJson());

class Credits {
  int id;
  List<Cast> cast;
  List<Crew> crew;

  Credits({
    this.id,
    this.cast,
    this.crew,
  });

  factory Credits.fromJson(Map<String, dynamic> json) => new Credits(
    id: json["id"],
    cast: new List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
    crew: new List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": new List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": new List<dynamic>.from(crew.map((x) => x.toJson())),
  };
}

class Cast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Cast({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => new Cast(
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    gender: json["gender"],
    id: json["id"],
    name: json["name"],
    order: json["order"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "gender": gender,
    "id": id,
    "name": name,
    "order": order,
    "profile_path": profilePath == null ? null : profilePath,
  };
}

class Crew {
  String creditId;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profilePath;

  Crew({
    this.creditId,
    this.department,
    this.gender,
    this.id,
    this.job,
    this.name,
    this.profilePath,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => new Crew(
    creditId: json["credit_id"],
    department: json["department"],
    gender: json["gender"],
    id: json["id"],
    job: json["job"],
    name: json["name"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "credit_id": creditId,
    "department": department,
    "gender": gender,
    "id": id,
    "job": job,
    "name": name,
    "profile_path": profilePath == null ? null : profilePath,
  };
}