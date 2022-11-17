import 'dart:convert';

import 'movie_model.dart';

Results convertFromList(String str) => Results.fromJson(json.decode(str));

class Results {
  List<Movie> results;

  Results({
    required this.results,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
      results: List<Movie>.from(
          json['results'].map((movie) => Movie.convertJsonFromList(movie))));
}
