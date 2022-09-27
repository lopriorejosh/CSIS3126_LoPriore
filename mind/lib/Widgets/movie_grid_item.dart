import 'package:flutter/material.dart';

import '../Screens/movie_description_page.dart';
import '../Models/movie.dart';

class MovieGridItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String genre;
  final double duration;
  final String id;
  final String description;

  MovieGridItem({
    required this.imageUrl,
    required this.duration,
    required this.genre,
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          MovieDescriptionPage.routeName,
          arguments: Movie(title, genre, description, duration, id, imageUrl),
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
