import 'package:flutter/material.dart';
import 'package:mind/Models/movie_model.dart';
import 'package:provider/provider.dart';

import '../Providers/movies_provider.dart';
import '../Widgets/my_drawer.dart';
import '../Widgets/my_appbar.dart';

class DummyPage extends StatelessWidget {
  static const routeName = '/dummy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(true),
      drawer: MyDrawer(),
      body: Center(
        child: ElevatedButton(
          child: Text('test'),
          onPressed: () {
            Provider.of<MoviesProvider>(context, listen: false)
                .getVideo(436270);
          },
        ),
      ),
    );
  }
}
