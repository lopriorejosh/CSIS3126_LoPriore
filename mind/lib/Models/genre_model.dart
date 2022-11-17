//import 'package:json_annotation/json_annotation.dart';

//part 'genre_model.g.dart';

//@JsonSerializable()
class Genre {
  String name;
  int id;
  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'], name: json['name']!);

/*
  //convert json data to genre class to add to movie
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
*/
}
