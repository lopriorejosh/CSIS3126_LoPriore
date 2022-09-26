import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final List<Movie> _topMovies = [
    Movie('title', 'genre', 'description', 20, 'id'),
  ];

  Future<void> getTopMovies() async {}
}
