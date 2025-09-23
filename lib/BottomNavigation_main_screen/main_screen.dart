import 'package:flutter/material.dart';

import '../Home_Screen/Home_Screen.dart';
import '../account_profile_screen/account_profile_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Index to keep track of the selected tab
  int _selectedIndex = 0;

  // List of the screens to be displayed
  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    AccountScreen(),
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body will now switch between screens based on the selected index
      body: _screens.elementAt(_selectedIndex),
      // The bottom navigation bar is now part of this parent screen
      bottomNavigationBar: _buildCommonBottomNavigationBar(),
    );
  }

  /// Builds the common bottom navigation bar for the entire app.
  Widget _buildCommonBottomNavigationBar() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // "Orders" Button
          _buildNavItem(
            icon: Icons.shopping_bag_outlined,
            label: 'Orders',
            index: 0,
          ),
          // "Account" Button
          _buildNavItem(
            icon: Icons.person_outline,
            label: 'Account',
            index: 1,
          ),
        ],
      ),
    );
  }

  /// Reusable helper widget for a navigation item.
  /// Its style changes based on whether it is currently selected.
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;

    // Use ElevatedButton for the selected item and TextButton for others
    if (isSelected) {
      return ElevatedButton.icon(
        onPressed: () => _onItemTapped(index),
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: const Color(0xFFFFD149),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
        ),
      );
    } else {
      return TextButton.icon(
        onPressed: () => _onItemTapped(index),
        icon: Icon(icon, color: Colors.black87),
        label: Text(
          label,
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.normal),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        ),
      );
    }
  }
}