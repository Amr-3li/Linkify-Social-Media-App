import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:true_gym/views/pages/app_pages/Exersieses.dart';
import 'package:true_gym/views/pages/app_pages/home_page.dart';
import 'package:true_gym/views/pages/app_pages/profile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    _selectedIndex = 0;
  }

  onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const Exersieses(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 60,
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: onItemTapped,
              tabBorderRadius: 30,
              //gap between icon and text
              gap: 5,
              //borrder over selected icon
              tabActiveBorder: Border.all(color: Colors.white),
              //animation on click icon
              rippleColor: const Color.fromARGB(255, 113, 37, 37),
              //press icon background color
              //hoverColor: Color.fromARGB(255, 43, 135, 53),
              //icon color
              activeColor: Colors.white,

              color: Colors.white.withOpacity(0.4),
              backgroundColor: const Color.fromARGB(255, 44, 44, 44),
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.fitness_center,
                  text: 'Exersieses',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
