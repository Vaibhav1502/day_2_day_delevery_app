import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Home_Screen/Home_Screen.dart';
import '../account_profile_screen/account_profile_screen.dart';
import '../orders_screen/orders_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    OrdersScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: _buildCommonBottomNavigationBar(),
    );
  }

  /// Builds the new, professional, and animated bottom navigation bar.
  Widget _buildCommonBottomNavigationBar() {
    return Container(
      // A bit more vertical padding for a modern look
      padding: const EdgeInsets.symmetric(vertical: 12),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: CupertinoIcons.home,
            label: 'Home',
            index: 0,
          ),
          _buildNavItem(
            icon: CupertinoIcons.bag,
            label: 'Orders',
            index: 1,
          ),
          _buildNavItem(
            icon: CupertinoIcons.person,
            label: 'Account',
            index: 2,
          ),
        ],
      ),
    );
  }

  /// Reusable helper widget for a navigation item with smooth animations.
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;

    // Using an Expanded with InkWell gives a larger, consistent tap area
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        // Use a transparent splash color for a cleaner effect
        splashColor: const Color(0xFFFFD149).withOpacity(0.1),
        highlightColor: const Color(0xFFFFD149).withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // This container creates the animated "pill" effect
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: isSelected
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 6)
                  : const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFD149) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Important to keep the pill snug
                children: [
                  Icon(
                    icon,
                    size: 24,
                    // Animate the color of the icon
                    color: isSelected ? Colors.black87 : Colors.grey[600],
                  ),
                  // The text appears smoothly only when selected
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: isSelected
                        ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}