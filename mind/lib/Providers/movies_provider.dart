import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final List<Movie> _topMovies = [
    Movie(
      'Thor',
      'Action',
      'Action adventure movie continuing on with the thor sequence of movies',
      90,
      'id',
      'https://lumiere-a.akamaihd.net/v1/images/p_thorloveandthunder_639_593cb642.jpeg',
    ),
    Movie(
      'Black Panther',
      'Action',
      'Follows the hero of wakanda and the black panther powerFollows the hero of wakanda and the black panther powerFollows the hero of wakanda and the black panther powerFollows the hero of wakanda and the black panther powerFollows the hero of wakanda and the black panther powerFollows the hero of wakanda and the black panther powerFollows the hero of wakanda and the black panther powerFollows the hero of wakanda and the black panther powerFollows the hero of wakanda and the black panther powerFollows the hero of wakanda and the black panther power',
      90,
      'id',
      'https://m.media-amazon.com/images/M/MV5BMTg1MTY2MjYzNV5BMl5BanBnXkFtZTgwMTc4NTMwNDI@._V1_.jpg',
    ),
    Movie(
      'Thor',
      'Action',
      'Action adventure movie continuing on with the thor sequence of movies',
      90,
      'id',
      'https://lumiere-a.akamaihd.net/v1/images/p_thorloveandthunder_639_593cb642.jpeg',
    ),
    Movie(
      'Black Panther',
      'Action',
      'Follows the hero of wakanda and the black panther power',
      90,
      'id',
      'https://m.media-amazon.com/images/M/MV5BMTg1MTY2MjYzNV5BMl5BanBnXkFtZTgwMTc4NTMwNDI@._V1_.jpg',
    ),
    Movie(
      'Thor',
      'Action',
      'Action adventure movie continuing on with the thor sequence of movies',
      90,
      'id',
      'https://lumiere-a.akamaihd.net/v1/images/p_thorloveandthunder_639_593cb642.jpeg',
    ),
    Movie(
      'Black Panther',
      'Action',
      'Follows the hero of wakanda and the black panther power',
      90,
      'id',
      'https://m.media-amazon.com/images/M/MV5BMTg1MTY2MjYzNV5BMl5BanBnXkFtZTgwMTc4NTMwNDI@._V1_.jpg',
    ),
  ];

  List<Movie> get topMovies => _topMovies;

  Future<void> getTopMovies() async {}
}
