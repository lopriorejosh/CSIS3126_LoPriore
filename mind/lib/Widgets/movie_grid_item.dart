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
                  adult: movieItem.adult,
                  backdrop_path: movieItem.backdrop_path,
                  budget: movieItem.budget,
                  genres: movieItem.genres,
                  id: movieItem.id,
                  original_language: movieItem.original_language,
                  original_title: movieItem.original_title,
                  overview: movieItem.overview,
                  popularity: movieItem.popularity,
                  poster_path: movieItem.poster_path,
                  release_date: movieItem.release_date,
                  revenue: movieItem.revenue,
                  runtime: movieItem.runtime,
                  tagline: movieItem.tagline,
                  title: movieItem.title,
                  video: movieItem.adult,
                  watchProviders: movieItem.watchProviders)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .125,
                child: Image.network(
                  ApiConstants.imageEndpoint +
                      ApiConstants.originalImageEndpoint +
                      movieItem.backdrop_path.toString(),
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
