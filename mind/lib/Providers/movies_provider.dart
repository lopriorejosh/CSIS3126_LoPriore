import 'dart:convert';
import 'dart:developer';

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
        log(response.body);
        List<Movie> _fetchedMovies = convertFromPopular(response.body).results;
        _popularMovies = _fetchedMovies;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
/*
  Future<void> getMovieDetails(Movie movie) async {
    var movieDets = Uri.parse('https://api.themoviedb.org/3/movie/${movie.id}' +
        ApiConstants.apiKey +
        '&language=en-US');
    try {
      var response = await http.get(movieDets);
      print(response.body);
      if (response.statusCode == 200) {
        Movie fetchedMovie =
            Movie.fromJson(response.body as Map<String, dynamic>);
        print(fetchedMovie);
      }
    } catch (error) {
      print(error);
    }
  }*/
}
