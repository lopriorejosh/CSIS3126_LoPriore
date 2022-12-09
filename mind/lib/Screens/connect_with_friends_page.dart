import 'package:flutter/material.dart';
import 'package:mind/Models/movie_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mind/Providers/movies_provider.dart';

import '../Widgets/my_appbar.dart';
import '../Models/user_model.dart';
import '../Models/genre_model.dart';

class ConnectWithFriendsPage extends StatefulWidget {
  const ConnectWithFriendsPage({super.key});

  static const routeName = '/connect';

  @override
  State<ConnectWithFriendsPage> createState() => _ConnectWithFriendsPageState();
}

class _ConnectWithFriendsPageState extends State<ConnectWithFriendsPage> {
  List<bool> addGenre = [];

  @override
  Widget build(BuildContext context) {
    //final friend = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: MyAppBar(false),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Please Select Some Genres to Narrow Search',
              style: TextStyle(
                  fontFamily: GoogleFonts.yesevaOne().fontFamily,
                  fontSize: 25,
                  color: Colors.greenAccent),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<MoviesProvider>(context).getGenres(),
              builder: ((context, snapshot) => ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: ((context, index) {
                    addGenre.add(false);
                    return ListTile(
                        trailing: IconButton(
                          icon: Icon(addGenre.elementAt(index)
                              ? Icons.check
                              : Icons.add),
                          onPressed: () {
                            setState(() {
                              addGenre[index] =
                                  addGenre[index] == false ? true : false;
                            });
                            //add to db
                          },
                        ),
                        selected: false,
                        title: Text(
                          snapshot.data![index].name.toString(),
                        ));
                  }))),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text('Done'))
        ],
      )),
    );
  }
}
