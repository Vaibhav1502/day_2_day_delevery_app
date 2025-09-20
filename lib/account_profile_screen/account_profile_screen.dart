import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildProfileInfo(),
                      const SizedBox(height: 32),
                      const Text(
                        'Options',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildOptionsList(),
                      const SizedBox(height: 24),
                      const Center(
                        child: Text(
                          'App Version 1.0.0 (30)',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Builds the top "Account" header with rounded corners and shadow.
  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.person_outline, size: 28),
        SizedBox(width: 8),
        Text(
          'Account',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// Builds the user's profile information section.
  Widget _buildProfileInfo() {
    return Row(
      children: [
        // Profile Avatar with Yellow Border
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber, width: 2),
          ),
          child: const CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xFFFFF9E6),
            child: Icon(Icons.person_outline, size: 40, color: Colors.amber),
          ),
        ),
        const SizedBox(width: 16),
        // User Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  const Text('Aman Sharma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.phone_outlined, '+91 9999988888', Colors.red),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.email_outlined, 'loremipsum@gmail.com', Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  /// Helper to create a row for info like phone and email.
  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  /// Builds the list of selectable options.
  Widget _buildOptionsList() {
    return Column(
      children: [
        _buildOptionItem(Icons.person_outline, 'Edit Profile'),
        _buildOptionItem(Icons.location_on_outlined, 'Allotted Area'),
        _buildOptionItem(Icons.card_giftcard_outlined, 'Refer and Earn'),
        _buildOptionItem(Icons.headset_mic_outlined, 'Support'),
        _buildOptionItem(Icons.quiz_outlined, 'FAQ'),
        _buildOptionItem(Icons.description_outlined, 'Terms and Conditions'),
        _buildOptionItem(Icons.visibility_outlined, 'Privacy Policy'),
        _buildOptionItem(Icons.calendar_today_outlined, 'Ask For Leave'),
        _buildOptionItem(Icons.logout, 'Log Out', isLogout: true),
      ],
    );
  }

  /// Reusable widget for each item in the options list.
  Widget _buildOptionItem(IconData icon, String title, {bool isLogout = false}) {
    final color = isLogout ? Colors.red : Colors.red.shade400;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: isLogout ? color : Colors.black87,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: color, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the custom bottom navigation bar.
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
          // "Orders" Button
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
            label: const Text('Orders'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              backgroundColor: const Color(0xFFFFD149),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0,
            ),
          ),
          // "Account" Button (Active)
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, color: Colors.black87),
            label: const Text(
              'Account',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}