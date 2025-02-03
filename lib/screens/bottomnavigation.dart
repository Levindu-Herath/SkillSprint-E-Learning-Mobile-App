import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:edu_app/screens/home_screen.dart';
import 'package:edu_app/screens/profile.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late HomePage homepage;
  late Profile profile;

  @override
  void initState() {
    super.initState();
    // Initialize the pages and widgets
    homepage = HomePage();
    profile = Profile();
    pages = [
      homepage,
      // Add your other pages here
      Container(color: Colors.blue), // Placeholder for the shopping page
      Container(color: Colors.green), // Placeholder for the wallet page
      profile,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.white,
        color: Color(0xFF674AEF),
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.assignment,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite_border_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
