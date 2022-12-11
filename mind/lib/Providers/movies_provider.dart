import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:http/http.dart' as http;

import '../API/api_constants.dart';
import '../Models/movie_model.dart';
import '../Models/video_model.dart';
import '../Models/genre_model.dart';
import '../Models/watch_providers_model.dart';
import '../Models/review_model.dart';

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

  Future<Movie> getMovieDetails(int id) async {
    Movie _movie = Movie(
        adult: false,
        genres: [],
        id: 0,
        original_language: 'n/a',
        original_title: 'n/a',
        popularity: 0,
        release_date: 'n/a',
        title: 'n/a',
        video: false,
        watchProviders: []);

    var movieDets = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US');
    try {
      final response = await http.get(movieDets);
      if (response.statusCode == 200) {
        _movie =
            Movie.fromJson(json.decode(response.body) as Map<String, dynamic>);
        return _movie;
      }
    } catch (error) {
      print(error);
      throw error;
    }
    return _movie;
  }

  Future<Video> getVideo(int id) async {
    List<Video> _videos = [];

    var movieVideoEndpoint = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US');
    try {
      final response = await http.get(movieVideoEndpoint);
      final _json = json.decode(response.body) as Map<String, dynamic>;
      _videos = List<Video>.from(
          _json['results'].map((video) => Video.fromJson(video)));

      //api issue if call returns no video default to nothing
      if (_videos.isEmpty) {
        _videos.add(Video(key: 'test'));
      }
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
      //print(_json);
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

//change filter to more genres
  Future<List<Movie>> discoverMovies() async {
    List<Movie> _discoverMovies = [];
    final discoverUrl = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=ture&page=1&with_watch_monetization_types=flatrate');
    try {
      final response = await http.get(discoverUrl);
      final _json = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        _discoverMovies = List<Movie>.from(
            _json['results'].map((movie) => Movie.fromJson(movie)));
      }
    } catch (error) {
      print(error);
    }
    return _discoverMovies;
  }

  Future<List<Review>> getMovieReviews(int movieId) async {
    List<Review> _movieReviews = [];

    final reviewsEndpoint = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US&page=1');
    try {
      final response = await http.get(reviewsEndpoint);
      final _json = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        _movieReviews = List<Review>.from(
            _json['results'].map((review) => Review.fromJson(review)));
      }
    } catch (error) {
      print(error);
    }
    return _movieReviews;
  }
}
