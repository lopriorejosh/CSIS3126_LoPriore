import 'package:mind/Models/results_model.dart';

import 'genre_model.dart';
import 'watch_providers_model.dart';
import 'review_model.dart';

class Movie {
  String title;
  String imageUrl;
  bool video;
  List<Genre>? genres;
  List<WatchProviders>? watchProviders;
  String description;
  int id;
  List<Review>? reviews;
  double? runtime;
  Movie(
      {required this.title,
      required this.imageUrl,
      required this.video,
      this.genres,
      this.watchProviders,
      required this.description,
      required this.id,
      this.reviews,
      this.runtime});

  /* factory Movie.fromJson(Map<String, dynamic> json) {
    final movie = Movie(
        title: json['title'],
        imageUrl: json['backdrop_path'],
        video: json['video'] as bool,
        genres: List<Genre>.from(
            json["genres"].map((genre) => Genre.fromJson(genre))),
        watchProviders: [],
        //List<WatchProviders>.from(json['results'].map((genre) => WatchProviders.fromJson(genre))),
        description: json['overview'],
        id: json['id'],
        reviews: [],
        //List<Review>.from(json['results'].map((review) => Review.fromJson(review))),
        runtime: (json['runtime'] as num).toDouble());
    //print(movie.genres);
    return movie;
  }*/

//convert from details api call
  factory Movie.detsFromJson(Map<String, dynamic> json) => Movie(
      title: json['title'],
      imageUrl: json['backdrop_path'],
      video: json['video'] as bool,
      genres: List<Genre>.from(
          json["genres"].map((genre) => Genre.fromJson(genre))),
      watchProviders: [],
      //List<WatchProviders>.from(json['results'].map((genre) => WatchProviders.fromJson(genre))),
      description: json['overview'],
      id: json['id'],
      reviews: [],
      //List<Review>.from(json['results'].map((review) => Review.fromJson(review))),
      runtime: (json['runtime'] as num).toDouble());

//convert json from api where response returns data inside the results list -- see api docs
  factory Movie.convertJsonFromList(Map<String, dynamic> json) {
    final _movie = Movie(
      title: json['title'],
      imageUrl: json['backdrop_path'] == null
          ? json['poster_path']
          : json['backdrop_path'],
      video: json['video'] as bool,
      watchProviders: [], //not in api call
      description: json['overview'],
      id: json['id'],
      reviews: [], //not in api call
      runtime: 0, //not in api call
    );
    return _movie;
  }
}
