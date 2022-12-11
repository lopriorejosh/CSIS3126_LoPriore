import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Providers/movies_provider.dart';

class TrailerWindow extends StatelessWidget {
  int _movieId;

  TrailerWindow(this._movieId);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: Provider.of<MoviesProvider>(context, listen: false)
            .getVideo(_movieId),
        builder: ((context, snapshot) {
          final videoId = snapshot.data?.key ?? 'test';
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height * .25,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (videoId == 'test') {
            return Container(
              decoration: BoxDecoration(color: Colors.black54),
              height: MediaQuery.of(context).size.height * .25,
              child: Center(child: Text('No Video Available')),
            );
          } else {
            final url = 'https://www.youtube.com/watch?v=${snapshot.data!.key}';
            final videoId = YoutubePlayer.convertUrlToId(url);
            _controller = YoutubePlayerController(
                initialVideoId: videoId!,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                ));
            return Container(
              height: MediaQuery.of(context).size.height * .25,
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
                  //FullScreenButton(),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
