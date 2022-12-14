import 'genre_model.dart';
import 'watch_providers_model.dart';

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

//convert json to movie model. this can be used from a variety of different api calls that may or may not include some of the fields hench the defaulting values
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
