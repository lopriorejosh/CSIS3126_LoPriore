import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind/Models/movie.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../Widgets/my_appbar.dart';
import '../Widgets/movieGridItem.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  var pageController = PageController();

  var appBar = MyAppBar();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            child: Image.network(
                fit: BoxFit.fill,
                'https://media.istockphoto.com/photos/movie-projector-on-dark-background-picture-id1007557230?b=1&k=20&m=1007557230&s=612x612&w=0&h=2ZZaKPuR-AfPav0cxVB5XG-fMoMSHz1_wpggcR3p9co='),
          ),
          ListTile(
            onTap: () {},
            title: Text('Home'),
            leading: Icon(Icons.home),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            title: Text('Friends'),
            leading: Icon(Icons.people),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            title: Text('Settings'),
            leading: Icon(Icons.settings),
          ),
          Divider(),
        ],
      )),
      body: SingleChildScrollView(
        controller: pageController,
        child: Column(children: [
          InkWell(
            child: Image.network(
                'https://lumiere-a.akamaihd.net/v1/images/p_thorloveandthunder_639_593cb642.jpeg'),
            onTap: () => print('Navigate to movie details'),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Today's must watch",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .25,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (ctx, index) => MovieGridItem(
                    'https://m.media-amazon.com/images/M/MV5BMTg1MTY2MjYzNV5BMl5BanBnXkFtZTgwMTc4NTMwNDI@._V1_.jpg')),
          ),
          Divider(),
          Placeholder(
            fallbackHeight: MediaQuery.of(context).size.height * .75,
          )
        ]),
      ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.black,
        selectedIndex: selectedIndex,
        onItemSelected: ((index) {
          setState(() {
            selectedIndex = index;
          });
        }),
        barItems: [
          BarItem(
            filledIcon: Icons.home_filled,
            outlinedIcon: Icons.home,
          ),
          BarItem(
            filledIcon: Icons.connect_without_contact_rounded,
            outlinedIcon: Icons.connect_without_contact_outlined,
          )
        ],
      ),
    );
  }
}
