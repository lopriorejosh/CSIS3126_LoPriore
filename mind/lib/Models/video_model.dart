class Video {
  String key;

  Video({required this.key});

  factory Video.fromJson(Map<String, dynamic> json) => Video(key: json['key']);
}
