import 'package:day_to_day_delevery_boy_app/document_checklist_screen/personal_documents_screen.dart';
import 'package:flutter/material.dart';

class DocumentChecklistScreen extends StatelessWidget {
  const DocumentChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        // Using Stack to place the button at the bottom over the list
        child: Stack(
          children: [
            // Scrollable content
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), // Space for the floating button
              child: Column(
                children: [
                  _buildHeaderCard(),
                  _buildDocumentList(),
                ],
              ),
            ),
            // Submit Button positioned at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                color: const Color(0xFFF9F9F9), // Match background color
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalDocumentsScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFCE38A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the yellow header card
  Widget _buildHeaderCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: const LinearGradient(
            colors: [Color(0xFFFBC609), Color(0xFFFFD149)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(text: 'Welcome to '),
                  TextSpan(
                    text: 'Day',
                    style: TextStyle(color: Color(0xFFC62828)),
                  ),
                  TextSpan(
                    text: '2',
                    style: TextStyle(color: Colors.green),
                  ),TextSpan(
                    text: 'Day',
                    style: TextStyle(color: Color(0xFFC62828)),
                  ),
                  TextSpan(text: ' Delivery'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Just a few steps to complete and then you can start earning with Us',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the entire list of pending and completed documents
  Widget _buildDocumentList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Pending Documents'),
          _buildDocumentTile('Personal Documents'),
          _buildDocumentTile('Vehicle Details'),
          _buildDocumentTile('Bank Account Details'),
          _buildDocumentTile('Emergency Details'),
          const SizedBox(height: 24),
          _buildSectionTitle('Completed Documents'),
          _buildDocumentTile(
            'Personal Information',
            isCompleted: true,
          ),
        ],
      ),
    );
  }

  /// Builds the section titles like "Pending Documents"
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// Reusable widget for each document item in the list
  Widget _buildDocumentTile(String title, {bool isCompleted = false}) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.2),
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Row(
            children: [
              if (isCompleted)
                const Icon(Icons.check, color: Colors.black, size: 20),
              if (isCompleted) const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}