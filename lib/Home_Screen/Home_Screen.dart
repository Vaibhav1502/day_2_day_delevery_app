import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// An enum to manage the state of the order filters cleanly.
enum OrderFilter { completed, pending }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variable to track the currently selected filter.
  OrderFilter _selectedFilter = OrderFilter.pending;

  @override
  Widget build(BuildContext context) {
    // NOTE: The Scaffold no longer has a bottomNavigationBar property.
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilterButtons(),
            _buildBodyContent(),
          ],
        ),
      ),
    );
  }

  /// Builds the top "Home" header with proper styling.
  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.house_fill, size: 28),
        SizedBox(width: 8),
        Text(
          'Home',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// Builds the row of filter buttons.
  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterButton(
              'Completed Orders',
              OrderFilter.completed,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildFilterButton(
              'Pending Orders',
              OrderFilter.pending,
              Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  /// A dynamic, reusable widget for a single filter button.
  Widget _buildFilterButton(String text, OrderFilter filter, Color activeColor) {
    final bool isActive = _selectedFilter == filter;

    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedFilter = filter;
        });
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: isActive ? Colors.white : activeColor,
        backgroundColor: isActive ? activeColor : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: activeColor, width: 1.5),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  /// Builds the main content area, which can show orders or an empty state.
  Widget _buildBodyContent() {
    switch (_selectedFilter) {
      case OrderFilter.completed:
        return _buildEmptyState('No Completed Orders', "assets/images/no_order.png");
      case OrderFilter.pending:
        return _buildEmptyState('No New Orders', 'assets/images/no_order.png');
    }
  }

  /// Builds the "No New Orders" empty state message with an image.
  Widget _buildEmptyState(String message, String imagePath) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 200,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}