import 'package:flutter/material.dart';

import '../Models/review_model.dart';

class MovieReviewTab extends StatelessWidget {
  final List<Review> reviews;

  MovieReviewTab(this.reviews);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: ((context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  reviews[index].content + ' - ' + reviews[index].author,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          )),
    );
  }
}
