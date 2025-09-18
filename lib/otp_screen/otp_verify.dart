import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../personal_info/personal_info.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a light grey background color similar to the image
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        // Make AppBar transparent and remove shadow
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Add a back button that matches the iOS style
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Main header text
              const Text(
                'Enter OTP to verify',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              // Description text with a clickable "Change" link
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                        text:
                        'A 6 digit OTP has been sent to your phone\nnumber +91 9999988888 '),
                    TextSpan(
                      text: 'Change',
                      style: const TextStyle(color: Color(0xFFE53935)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle "Change" number tap
                          print('Change number tapped');
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Label for the OTP input
              Text(
                'Enter OTP Text',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              // Row of OTP input boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOtpBox('1'),
                  _buildOtpBox('7'),
                  _buildOtpBox('2'),
                  _buildOtpBox('8'),
                  _buildOtpBox('9'),
                  _buildOtpBox('2'),
                ],
              ),
              const SizedBox(height: 40),
              // Verify OTP button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalInfoScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD149),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget to build a single OTP digit box
  Widget _buildOtpBox(String digit) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          digit,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}