// To parse this JSON data, do
//
//     final moviesList = moviesListFromJson(jsonString);

import 'dart:convert';

MoviesListModel moviesListFromJson(String str) =>
    MoviesListModel.fromJson(json.decode(str));

String moviesListToJson(MoviesListModel data) => json.encode(data.toJson());

class MoviesListModel {
  List<Movie> movies;

  MoviesListModel({
    required this.movies,
  });

  factory MoviesListModel.fromJson(Map<String, dynamic> json) => MoviesListModel(
        movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
      };
}

class Movie {
  String id;
  String title;
  String year;
  List<String> genres;
  List<int> ratings;
  String poster;
  dynamic contentRating;
  String duration;
  String releaseDate;
  dynamic averageRating;
  OriginalTitle originalTitle;
  String storyline;
  List<String> actors;
  dynamic imdbRating;
  String posterurl;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.ratings,
    required this.poster,
    required this.contentRating,
    required this.duration,
    required this.releaseDate,
    required this.averageRating,
    required this.originalTitle,
    required this.storyline,
    required this.actors,
    required this.imdbRating,
    required this.posterurl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        year: json["year"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        ratings: List<int>.from(json["ratings"].map((x) => x)),
        poster: json["poster"],
        contentRating: json["contentRating"],
        duration: json["duration"],
        releaseDate: json["releaseDate"],
        averageRating: json["averageRating"],
        originalTitle: originalTitleValues.map[json["originalTitle"]]!,
        storyline: json["storyline"],
        actors: List<String>.from(json["actors"].map((x) => x)),
        imdbRating: json["imdbRating"],
        posterurl: json["posterurl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "year": year,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "ratings": List<dynamic>.from(ratings.map((x) => x)),
        "poster": poster,
        "contentRating": contentRating,
        "duration": duration,
        "releaseDate": releaseDate,
        "averageRating": averageRating,
        "originalTitle": originalTitleValues.reverse[originalTitle],
        "storyline": storyline,
        "actors": List<dynamic>.from(actors.map((x) => x)),
        "imdbRating": imdbRating,
        "posterurl": posterurl,
      };
}

enum OriginalTitle {
  ANNIHILATION,
  A_WRINKLE_IN_TIME,
  CE_QUI_NOUS_LIE,
  EMPTY,
  THE_LEISURE_SEEKER
}

final originalTitleValues = EnumValues({
  "Annihilation": OriginalTitle.ANNIHILATION,
  "A Wrinkle in Time": OriginalTitle.A_WRINKLE_IN_TIME,
  "Ce qui nous lie": OriginalTitle.CE_QUI_NOUS_LIE,
  "": OriginalTitle.EMPTY,
  "The Leisure Seeker": OriginalTitle.THE_LEISURE_SEEKER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
