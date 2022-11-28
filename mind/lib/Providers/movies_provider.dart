import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../API/api_constants.dart';
import '../Models/movie_model.dart';
import '../Models/results_model.dart';

class MoviesProvider extends ChangeNotifier {
  late List<Movie> _popularMovies = [];
  late List<Movie> _topRatedMovies = [];
  late Movie _singleMovieSelected;

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  Movie get singleMovieSelected => _singleMovieSelected;

  Future<void> fetchMovieList(String typeListWanted) async {
    var movieListUrl = typeListWanted == 'popular'
        ? Uri.parse(ApiConstants.baseUrl +
            ApiConstants.popularMoviesEndpoint +
            ApiConstants.apiKey)
        : Uri.parse(ApiConstants.baseUrl +
            ApiConstants.topRatedMoviesEndpoint +
            ApiConstants.apiKey);
    try {
      var response = await http.get(movieListUrl);
      if (response.statusCode == 200) {
        //convert json data and set _popularMovies
        List<Movie> _fetchedMovies = convertFromList(response.body).results;
        typeListWanted == 'popular'
            ? _popularMovies = _fetchedMovies
            : _topRatedMovies = _fetchedMovies;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> getMovieDetails(int id) async {
    var movieDets = Uri.parse('https://api.themoviedb.org/3/movie/${id}' +
        ApiConstants.apiKey +
        '&language=en-US');
    try {
      final response = await http.get(movieDets);
      if (response.statusCode == 200) {
        final fetchedMovie = Movie.detsFromJson(
            json.decode(response.body) as Map<String, dynamic>);
        _singleMovieSelected = fetchedMovie;
        print(_singleMovieSelected.genres[0].name);
        print(_singleMovieSelected.watchProviders[0].providerName);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> getVideo(int id) async {
    var movieVideoEndpoint = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US');
    try {
      final response = await http.get(movieVideoEndpoint);
      print(response.body);
    } catch (error) {
      print(error);
    }
  }
}
