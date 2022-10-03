import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mind/API/json_convert_data.dart';

import '../API/api_constants.dart';
//import '../Models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final List<MovieInfo> _popularMovies = [];

  List<MovieInfo> get topMovies => _popularMovies;

  Future<void> getPopularMovies() async {
    var topMoviesUrl = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.popularMoviesEndpoint +
        ApiConstants.apiKey);
    try {
      var response = await http.get(topMoviesUrl);
      if (response.statusCode == 200) {
        //convert json data and set _popularMovies to List
        log(response.body);
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
