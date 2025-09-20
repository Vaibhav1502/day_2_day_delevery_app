import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../registration_complete_screen/registration_screen.dart';
import '../submission_success_screen/submission_success_screen.dart';

class AadharCardScreen extends StatelessWidget {
  const AadharCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 100.0), // Space for button
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Aadhar card details',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Upload focused photo of your Aadhar Card for faster verification',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Reusable upload box widget
                  _buildUploadBox(
                    'Front side photo of your Aadhar card with your clear name and photo',
                  ),
                  const SizedBox(height: 20),
                  _buildUploadBox(
                    'Back side photo of your Aadhar card with your clear name and photo', // Text changed for clarity
                  ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SubmissionSuccessScreen()));
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

  /// Helper widget to build the dotted border upload box
  Widget _buildUploadBox(String description) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      color: Colors.grey[400]!,
      strokeWidth: 1,
      dashPattern: const [6, 6],
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                // Handle photo upload
              },
              icon: Icon(Icons.camera_alt, color: Colors.red[400]),
              label: Text(
                'Upload Photo',
                style: TextStyle(color: Colors.red[400]),
              ),
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.red[100]!),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              ),
            )
          ],
        ),
      ),
    );
  }
}