import 'package:flutter/material.dart';
import 'package:zoe/screens/main_screens/explore_people.dart';
import 'package:zoe/screens/main_screens/messages.dart';
import 'package:zoe/screens/main_screens/user_profile.dart';
import 'package:zoe/screens/main_screens/your_matches.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _selectedTab = 0;

class _HomeScreenState extends State<HomeScreen> {
  final List _pages = [
    const ExplorePeopleScreen(),
    const YourMatchesScreen(),
    const MessagesScreen(),
    UserProfileScreen(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
