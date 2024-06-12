import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:watch/screens/ai.dart';
import 'package:watch/screens/landing.dart';
import 'package:watch/screens/record.dart';
import 'package:watch/screens/store.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const LandingPage();

    if (_selectedPageIndex == 1) {
      activePage = const RecordScreen();
    } else if (_selectedPageIndex == 2) {
      activePage = const AiScreen();
    } else if (_selectedPageIndex == 3) {
      activePage = StoreScreen();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesome5Solid.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesome5Solid.running), label: 'Exercise'),
          BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.face_man_shimmer), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Store'),
        ],
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors
            .orangeAccent, // Optional: Change the color of the selected item
        unselectedItemColor:
            Colors.white, // Optional: Change the color of unselected items
      ),
    );
  }
}
