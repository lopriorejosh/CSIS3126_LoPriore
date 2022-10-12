import 'package:flutter/material.dart';
import 'package:mind/Providers/friends_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import './Screens/home_page.dart';
import './Providers/movies_provider.dart';
import './Screens/movie_description_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MoviesProvider>(create: (_) => MoviesProvider()),
      ChangeNotifierProvider<FriendsProvider>(create: (_) => FriendsProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mind',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        bottomAppBarColor: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: GoogleFonts.satisfy().fontFamily,
            fontSize: 30.0,
          ),
          titleMedium: TextStyle(
            fontFamily: GoogleFonts.play().fontFamily,
            fontSize: 30.0,
          ),
          displayMedium: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontFamily: GoogleFonts.yesevaOne().fontFamily,
          ),
          bodyLarge: TextStyle(
            fontFamily: GoogleFonts.acme().fontFamily,
          ),
          labelLarge: TextStyle(
            fontSize: 30,
            fontFamily: GoogleFonts.yesevaOne().fontFamily,
          ),
          labelSmall: TextStyle(
            fontSize: 15,
            fontFamily: GoogleFonts.yesevaOne().fontFamily,
          ),
        ),
        appBarTheme: const AppBarTheme(color: Colors.transparent),
      ),
      home: HomePage(),
      routes: {
        MovieDescriptionPage.routeName: (context) => MovieDescriptionPage(),
      },
    );
  }
}
