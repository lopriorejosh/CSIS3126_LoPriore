import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './Screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mind',
      theme: ThemeData(
          //brightness: Brightness.dark,
          primarySwatch: Colors.green,
          //scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(color: Colors.transparent)),
      home: HomePage(),
    );
  }
}
