import 'package:flutter/material.dart';

class MovieGridItem extends StatelessWidget {
  final String imageUrl;

  MovieGridItem(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
