import 'package:mind/Models/results_model.dart';

import 'genre_model.dart';
import 'watch_providers_model.dart';
import 'review_model.dart';

/*class Movie {
  String title;
  String imageUrl;
  bool video;
  List<Genre>? genres;
  List<WatchProvider>? watchProviders;
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
      imageUrl: json['backdrop_path'] == null ? '' : json['backdrop_path'],
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
*/
class Movie {
  bool adult;
  String? backdrop_path;
  int? budget;
  List<Genre> genres;
  int id;
  String original_language;
  String original_title;
  String? overview;
  double popularity;
  String? poster_path;
  String release_date;
  int? revenue;
  int? runtime;
  String? tagline;
  String title;
  bool video;
  List<WatchProvider> watchProviders;

  Movie(
      {required this.adult,
      this.backdrop_path,
      this.budget,
      required this.genres,
      required this.id,
      required this.original_language,
      required this.original_title,
      this.overview,
      required this.popularity,
      this.poster_path,
      required this.release_date,
      this.revenue,
      this.runtime,
      this.tagline,
      required this.title,
      required this.video,
      required this.watchProviders});

  factory Movie.fromJson(Map<String, dynamic> json) {
    final _genresData =
        json['genres'] == null ? <Genre>[] : json['genres'] as List<dynamic>?;
    List<Genre> _genres = _genresData != []
        ? _genresData!.map((genre) => Genre.fromJson(genre)).toList()
        : <Genre>[];

    final _wpData =
        json['US'] == null ? <WatchProvider>[] : json['US'] as List<dynamic>?;
    List<WatchProvider> _wp = _wpData != []
        ? _wpData!.map((wp) => WatchProvider.fromJson(wp)).toList()
        : <WatchProvider>[];

    final movie = Movie(
        adult: json['adult'] as bool,
        budget: json['budget'] ?? 0,
        backdrop_path:
            json['backdrop_path'] == null ? '' : json['backdrop_path'],
        genres: _genres,
        id: json['id'],
        original_language: json['original_language'],
        original_title: json['original_title'],
        overview: json['overview'] ?? 'No Description Provided',
        popularity: json['popularity'],
        poster_path: json['poster_path'] == null
            ? 'https://st4.depositphotos.com/17828278/24401/v/600/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg'
            : json['poster_path'],
        release_date: json['release_date'],
        revenue: json['revenue'] ?? 0,
        runtime: json['runtime'] ?? 0,
        tagline: json['tagline'] ?? 'No Tagline',
        title: json['title'],
        video: json['video'],
        watchProviders: _wp);
    return movie;
  }
}
