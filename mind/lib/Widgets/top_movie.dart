import 'package:flutter/material.dart';

class TopMovie extends StatelessWidget {
  final String imageUrl;
  final String title;

  TopMovie({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(75),
            bottomRight: Radius.circular(75),
          )),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .6,
          child: Image.network(
            imageUrl,
            fit: BoxFit.fitHeight,
          ),
        ),
        onTap: () => print('go to page')
        //Navigator.of(context).pushNamed(MovieDescriptionPage.routeName, arguments: Movie),
        );
  }
}
