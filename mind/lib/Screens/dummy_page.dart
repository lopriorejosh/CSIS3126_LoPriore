import 'package:flutter/material.dart';
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
      body: /*Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Plot: '),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .3,
                  child: FutureBuilder(
                      future:
                          Provider.of<MoviesProvider>(context, listen: false)
                              .getSingleMovieGenre(11),
                      builder: ((context, snapshot) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: ((context, index) => SizedBox(
                                width: 20,
                                child: Card(
                                    child: Text(
                                        snapshot.data![index].name.toString())),
                              )),
                        );
                      })),
                ),
              ]),
            ),
          ),
        ),*/
          Center(
        child: ElevatedButton(
          child: Text('test'),
          onPressed: () {
            Provider.of<MoviesProvider>(context, listen: false)
                .getVideo(1049233);
          },
        ),
      ),
    );
  }
}
