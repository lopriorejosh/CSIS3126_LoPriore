import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mind/Widgets/my_appbar.dart';
import 'package:mind/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/video_model.dart';
import '../Models/movie_model.dart';
import '../Providers/movies_provider.dart';

class MovieTrailerPage extends StatefulWidget {
  static const routeName = '/youtubePlayer';

  const MovieTrailerPage({super.key});

  @override
  State<MovieTrailerPage> createState() => _MovieTrailerPageState();
}

class _MovieTrailerPageState extends State<MovieTrailerPage> {
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    int _movieId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
          future: Provider.of<MoviesProvider>(context, listen: false)
              .getVideo(_movieId),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              print(snapshot.data?.key);
              final url =
                  'https://www.youtube.com/watch?v=${snapshot.data?.key}';
              final videoId = YoutubePlayer.convertUrlToId(url);
              _controller = YoutubePlayerController(
                  initialVideoId: videoId!,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                  ));
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(
                        isExpanded: true,
                        colors: ProgressBarColors(
                            playedColor: Theme.of(context).backgroundColor,
                            handleColor: Theme.of(context).primaryColorLight),
                      ),
                      const PlaybackSpeedButton(),
                      FullScreenButton(),
                    ],
                  ),
                ),
              );
            }
          }),
        ));
  }
}
