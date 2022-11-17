class Review {
  //convert json data to review to add to movie
  String content;
  String author;

  Review({
    required this.content,
    required this.author,
  });

//convert json data to watch providers to add to movie
  /*factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
*/
}
