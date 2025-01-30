import 'package:bhi/constant/pallete.dart';
import 'package:bhi/pages/auth/login_screen.dart';
import 'package:bhi/pages/home/homeview.dart';
import 'package:bhi/pages/home/library.dart';
import 'package:bhi/pages/home/profile.dart';
import 'package:bhi/pages/home/analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const HomePage(), // Replace with actual content
    const LibraryPage(),
    const OrderAnalyticsPage(),
    const ProfilePage(),
  ];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        showUnselectedLabels: true,
        backgroundColor: Pallete.mainDashColor,
        selectedItemColor: Pallete.mainDashColor,
        unselectedItemColor: Colors.black38,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
