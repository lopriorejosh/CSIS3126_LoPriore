import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mind/Models/movie_model.dart';

import '../API/api_constants.dart';
//import '../Models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  late List<Movie> _popularMovies = [];

  List<Movie> get popularMovies => _popularMovies;

  Future<void> FetchPopularMovies() async {
    var topMoviesUrl = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.popularMoviesEndpoint +
        ApiConstants.apiKey);
    try {
      var response = await http.get(topMoviesUrl);
      if (response.statusCode == 200) {
        //convert json data and set _popularMovies
        List<Movie> _fetchedMovies = convertFromJson(response.body).results;
        _popularMovies = _fetchedMovies;
        print(_popularMovies[0].id);
        print(_popularMovies[0].backdropPath);
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
