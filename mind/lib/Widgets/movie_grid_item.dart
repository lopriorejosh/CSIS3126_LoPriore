import 'package:flutter/material.dart';
import 'package:mind/API/api_constants.dart';

import '../Screens/movie_description_page.dart';
import '../Models/movie_model.dart';

class MovieGridItem extends StatelessWidget {
  Movie movieItem;

  MovieGridItem(this.movieItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(
                MovieDescriptionPage.routeName,
                arguments: Movie(
                    title: movieItem.title,
                    description: movieItem.description,
                    id: movieItem.id,
                    imageUrl: movieItem.imageUrl,
                    genres: movieItem.genres,
                    video: movieItem.video,
                    reviews: movieItem.reviews,
                    watchProviders: movieItem.watchProviders,
                    runtime: movieItem.runtime),
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .125,
                child: Image.network(
                  ApiConstants.imageEndpoint +
                      ApiConstants.originalImageEndpoint +
                      movieItem.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Divider(),
              RichText(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: movieItem.title,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              )
            ],
          )),
    );
  }
}
