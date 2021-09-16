import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/favorite_screen.dart';
import 'package:restaurant_app/screens/restaurant_screen.dart';
import 'package:restaurant_app/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavBarIndex = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavBarIndex = index;
    });
  }

  final List _screens = [
    RestaurantScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedNavBarIndex],
      bottomNavigationBar: _buildBottomNavigationBar(
          currentIndex: _selectedNavBarIndex, action: _changeSelectedNavBar),
    );
  }
}

Widget _buildBottomNavigationBar(
    {required int currentIndex, required Function(int index) action}) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
    ],
    currentIndex: currentIndex,
    onTap: action,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
  );
}
