class Genre {
  List<Genre>? genres;
  String? name;
  int? id;

  Genre({this.id, this.name, this.genres});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
      id: json['id'] ?? null,
      name: json['name'] ?? null,
      genres: json['genres'] ?? <Genre>[]);
}
