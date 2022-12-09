import 'dart:convert';
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mind/Models/genre_model.dart';
import 'package:mind/Models/watch_providers_model.dart';

import '../API/api_constants.dart';
import '../Models/movie_model.dart';
import '../Models/results_model.dart';
import '../Models/video_model.dart';

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
        final _json = json.decode(response.body) as Map<String, dynamic>;
        //convert json data and set _popularMovies
        List<Movie> _fetchedMovies = List<Movie>.from(
            _json['results'].map((movie) => Movie.fromJson(movie)));
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
    var movieDets = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US');
    try {
      final response = await http.get(movieDets);
      if (response.statusCode == 200) {
        final fetchedMovie =
            Movie.fromJson(json.decode(response.body) as Map<String, dynamic>);
        _singleMovieSelected = fetchedMovie;
        print(fetchedMovie.video);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<Video> getVideo(int id) async {
    List<Video> _videos = [];

    var movieVideoEndpoint = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US');
    try {
      final response = await http.get(movieVideoEndpoint);
      final _json = json.decode(response.body) as Map<String, dynamic>;
      //print(_json);
      _videos = List<Video>.from(
          _json['results'].map((video) => Video.fromJson(video)));
    } catch (error) {
      print(error);
    }
    return _videos[0];
  }

  Future<List<Genre>> getGenres() async {
    List<Genre> _genres = [];

    final movieGenres = Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US');
    try {
      final response = await http.get(movieGenres);
      final _json = json.decode(response.body) as Map<String, dynamic>;
      print(_json);
      _genres = List<Genre>.from(
          _json['genres'].map((genre) => Genre.fromJson(genre)));
    } catch (error) {
      print(error);
    }
    return _genres;
  }

  Future<List<Genre>> getSingleMovieGenre(int id) async {
    List<Genre> _genres = [];

    final singleMovieGenresUrl = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US');

    try {
      final response = await http.get(singleMovieGenresUrl);
      final _json = json.decode(response.body) as Map<String, dynamic>;
      _genres = List<Genre>.from(
          _json['genres'].map((genre) => Genre.fromJson(genre)));
    } catch (error) {
      print(error);
    }
    return _genres;
  }

  Future<List<WatchProvider>> getSingleMovieWP(int id) async {
    List<WatchProvider> _wp = [];

    final singleMovieWP = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/watch/providers?api_key=ffd47d62f4e4b8d58336acf31f7c2550');

    try {
      final response = await http.get(singleMovieWP);
      final _json = json.decode(response.body) as Map<String, dynamic>;
      _wp = _json['results']['US']['flatrate'] == null
          ? <WatchProvider>[]
          : List<WatchProvider>.from(_json['results']['US']['flatrate']
              .map((wp) => WatchProvider.fromJson(wp)));
    } catch (error) {
      print(error);
    }
    return _wp;
  }
}
