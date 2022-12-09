/*import 'dart:convert';

import 'movie_model.dart';

Results convertFromList(String str) => Results.fromJson(json.decode(str));

class Results {
  List<Movie> results;

  Results({
    required this.results,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
        results: List<Movie>.from(
            json['results'].map((movie) => Movie.fromJson(movie))));
  }
}
*/