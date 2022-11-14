import 'dart:convert';

convertPopJson convertFromPopular(String str) =>
    convertPopJson.fromJson(json.decode(str));

class convertPopJson {
  convertPopJson({
    required this.results,
  });

  List<Movie> results;

  factory convertPopJson.fromJson(Map<String, dynamic> json) => convertPopJson(
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );
}

class Movie {
  Movie(
      {required this.title,
      required this.imageUrl,
      required this.video,
      required this.genres,
      required this.watchProviders,
      required this.description,
      required this.id,
      required this.reviews,
      required this.runtime});
  String title;
  String imageUrl;
  bool video;
  List<Genre> genres;
  List<WatchProviders> watchProviders;
  String description;
  final id;
  List<Review> reviews;
  double runtime;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      title: json['title'],
      imageUrl: json['backdrop_path'],
      video: json['video'] as bool,
      genres: [],
      //List<Genre>.from(json['genres'].map((genre) => Genre.fromJson(genre))),
      watchProviders: [],
      //List<WatchProviders>.from(json['results'].map((genre) => WatchProviders.fromJson(genre))),
      description: json['overview'],
      id: json['id'],
      reviews: [],
      //List<Review>.from(json['results'].map((review) => Review.fromJson(review))),
      runtime: 0
      //json['runtime']
      );
}

class Genre {
  late List<String> name;
  late List<String> id;

  Genre({
    required this.id,
    required this.name,
  });

  //convert json data to genre class to add to movie
  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'], name: json['name']);
}

class WatchProviders {
  late String country;
  late String providerName;

  WatchProviders({
    required this.country,
    required this.providerName,
  });

//convert json data to watch providers to add to movie
  factory WatchProviders.fromJson(Map<String, dynamic> json) => WatchProviders(
      country: json['US'], providerName: json['flatrate']['provider_name']);
}

class Review {
  //convert json data to review to add to movie
  late String content;
  late String author;

  Review({
    required this.content,
    required this.author,
  });

//convert json data to watch providers to add to movie
  factory Review.fromJson(Map<String, dynamic> json) => Review(
      content: json['content'], author: json['author_details']['usernames']);
}
