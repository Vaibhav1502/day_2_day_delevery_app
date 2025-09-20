import 'package:flutter/material.dart';
import '../account_profile_screen/account_profile_screen.dart';

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
    return Scaffold(
      // A light grey background is often more professional and easier on the eyes.
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilterButtons(),
            // The body content will now depend on the selected filter.
            _buildBodyContent(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Builds the top "Home" header with proper styling.
  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.home, size: 28),
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
  /// Its appearance changes based on whether it is active.
  Widget _buildFilterButton(String text, OrderFilter filter, Color activeColor) {
    final bool isActive = _selectedFilter == filter;

    return OutlinedButton(
      onPressed: () {
        // When pressed, update the state to the new filter.
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
    // This is now structured to easily add order lists in the future.
    // For now, both states show the "No New Orders" message.
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
              //color: Colors.grey.shade300, // Makes the image more subtle
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

  /// Builds a professional bottom navigation bar that clearly shows the active tab.
  Widget _buildBottomNavigationBar() {
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
          // "Orders" Button (Active)
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined,color: Colors.black87,),
            label: const Text('Orders'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              backgroundColor: const Color(0xFFFFD149),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 0,
            ),
          ),
          // "Account" Button (Inactive)
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
            icon: const Icon(Icons.person_2_outlined,color: Colors.black87,),
            label: const Text('Account'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              backgroundColor: const Color(0xFFFFD149),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}