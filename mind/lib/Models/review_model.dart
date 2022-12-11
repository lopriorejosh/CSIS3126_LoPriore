class Review {
  //convert json data to review to add to movie
  String content;
  String author;

  Review({
    required this.content,
    required this.author,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(content: json['content'], author: json['author']);
  }
}
