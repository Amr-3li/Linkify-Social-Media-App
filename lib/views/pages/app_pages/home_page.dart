import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:true_gym/views/pages/app_pages/exersieses.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            stops: [0.3, 0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 0, 0, 0),
            ]),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          width: 290,
          clipBehavior: Clip.hardEdge,
          elevation: 5,
          semanticLabel: 'Navigation Drawer',
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(250.0)),
          ),
          backgroundColor: Color.fromARGB(255, 103, 103, 103),
          child: ListView(
            children: const [
              UserAccountsDrawerHeader(
                accountName: Text('Amr'),
                accountEmail: Text('5kNjC@example.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text('Profile',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Settings',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.help, color: Colors.white),
                title: Text('Help',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text('About',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.share, color: Colors.white),
                title: Text('Share',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              ListTile(
                leading: Icon(Icons.rate_review, color: Colors.white),
                title: Text('Rate Us',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('Logout',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          buttonSize: const Size(80, 80),
          icon: Icons.fitness_center,
          backgroundColor: const Color.fromARGB(255, 135, 135, 135),
          overlayOpacity: 0.3,
          spaceBetweenChildren: 15,
          closeManually: true,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Exersieses()),
            );
          },
        ),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 135, 135, 135),
          title: const Text(
            'True Gym',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
        body: const Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
