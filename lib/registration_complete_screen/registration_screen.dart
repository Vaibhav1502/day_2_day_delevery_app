import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegistrationStatusScreen extends StatelessWidget {
  const RegistrationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildVerificationBanner(),
                    const SizedBox(height: 24),
                    _buildStatusList(),
                    const SizedBox(height: 40),
                    _buildHelpFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the top header with back button and title.
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const Expanded(
          child: Text(
            'Registration Status',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 48), // To balance the back button space
      ],
    );
  }

  /// Builds the yellow "Under Verification" banner.
  Widget _buildVerificationBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your application is under\nVerification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Account will get activated in 48hrs',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/Character 2.png',
            height: 80,
          ),
        ],
      ),
    );
  }

  /// Builds the list of status items.
  Widget _buildStatusList() {
    return Column(
      children: [
        _buildStatusTile(
          title: 'Personal Information',
          status: 'Approved',
          statusColor: Colors.green,
        ),
        _buildStatusTile(
          title: 'Personal Documents',
          status: 'Verification Pending',
          statusColor: Colors.red,
        ),
        _buildStatusTile(
          title: 'Vehicle Details',
          status: 'Approved',
          statusColor: Colors.green,
        ),
        _buildStatusTile(
          title: 'Bank Account Details',
          status: 'Approved',
          statusColor: Colors.green,
        ),
        _buildStatusTile(
          title: 'Emergency Details',
          status: 'Approved',
          statusColor: Colors.green,
        ),
      ],
    );
  }

  /// Reusable widget for a single status item card.
  Widget _buildStatusTile({
    required String title,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 14,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the "Need Help?" footer.
  Widget _buildHelpFooter() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 15, color: Colors.black54),
        children: [
          const TextSpan(text: 'Need Help? '),
          TextSpan(
            text: 'Contact Us',
            style: const TextStyle(
              color: Colors.red,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle Contact Us tap
                print('Contact Us tapped!');
              },
          ),
        ],
      ),
    );
  }
}