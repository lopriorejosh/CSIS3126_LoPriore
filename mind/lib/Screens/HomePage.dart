import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mind',
          style: GoogleFonts.lobster(),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        ],
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: const BoxDecoration(color: Colors.black54),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .45,
              child: const Center(
                child: Text(
                  'Image will go here',
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Today's must watch: ",
                style: GoogleFonts.lobster(fontSize: 20),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .25,
                    width: MediaQuery.of(context).size.width * .45,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'test',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .25,
                    width: MediaQuery.of(context).size.width * .45,
                    color: Colors.orange,
                    child: Center(
                      child: Text(
                        'test',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .25,
                    width: MediaQuery.of(context).size.width * .45,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'test',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              decoration: BoxDecoration(color: Colors.black54),
              height: MediaQuery.of(context).size.height * .45,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Friends List here',
                ),
              ),
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
      ]),
    );
  }
}
