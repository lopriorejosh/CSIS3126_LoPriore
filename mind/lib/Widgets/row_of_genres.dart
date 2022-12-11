import 'package:flutter/material.dart';

import '../Models/genre_model.dart';

class RowOfGenres extends StatelessWidget {
  List<Genre> items = [];

  RowOfGenres(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          print(items);
          return items.length == 0
              ? Text('No Genres Found')
              : SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .15,
                  child: Card(
                      child: Text('Item: ' + items[index].name.toString())));
        });
  }
}
