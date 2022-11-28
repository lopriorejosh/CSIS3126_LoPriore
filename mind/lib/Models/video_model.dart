class Video {
  bool official;
  String videoId;

  Video({required this.official, required this.videoId});

  factory Video.fromVideoJson(Map<String, dynamic> json) =>
      Video(official: json['official'], videoId: json['id']);
}
