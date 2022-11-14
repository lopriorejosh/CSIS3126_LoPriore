import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../API/api_constants.dart';
import '../Models/movie_model.dart';

class MoviesProvider extends ChangeNotifier {
  late List<Movie> _popularMovies = [];

  List<Movie> get popularMovies => _popularMovies;

  Future<void> fetchPopularMovies() async {
    var popularMoviesUrl = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.popularMoviesEndpoint +
        ApiConstants.apiKey);
    try {
      var response = await http.get(popularMoviesUrl);
      if (response.statusCode == 200) {
        //convert json data and set _popularMovies
        List<Movie> _fetchedMovies = convertFromJson(response.body).results;
        _popularMovies = _fetchedMovies;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
