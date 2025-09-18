import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../document_checklist_screen/document_checklist_screen.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFFF9F9F9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Personal information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the details below so we can get to know and serve you better',
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
                const SizedBox(height: 24),

                // Form Fields
                _buildTextField(label: 'First Name', hint: 'Please enter first name'),
                _buildTextField(label: 'Last Name', hint: 'Please enter last name'),
                _buildTextField(label: 'Father\'s Name', hint: 'Please enter father\'s name'),
                _buildTextField(
                  label: 'Date of birth',
                  hint: 'dd-mm-yyyy',
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.red[400]),
                ),
                _buildTextField(label: 'Primary mobile number', hint: '+91 9999988888', isEnabled: false),
                _buildTextField(label: 'WhatsApp number', hint: '+91 9999988888'),
                _buildTextField(label: 'Secondary mobile number (Optional)', hint: 'e.g. 9999999999'),
                _buildTextField(label: 'Blood Group', hint: 'Enter blood group here'),
                _buildTextField(
                  label: 'City',
                  hint: 'e.g. Ahemdabad',
                  suffixIcon: const Icon(Icons.arrow_forward_ios, size: 16),
                  isReadOnly: true,
                ),
                _buildTextField(label: 'Enter complete address here', hint: 'Search address'),
                _buildTextField(
                  label: 'Languages you know',
                  hint: 'Select one or multiple',
                  suffixIcon: const Icon(Icons.arrow_forward_ios, size: 16),
                  isReadOnly: true,
                ),

                // Profile Picture Section
                const SizedBox(height: 16),
                const Text('Your Profile Picture', style: TextStyle(color: Color(0xFF616161), fontSize: 14)),
                const SizedBox(height: 8),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  color: Colors.grey[400]!,
                  strokeWidth: 1,
                  dashPattern: const [6, 6],
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Color(0xFFE0E0E0),
                          child: Icon(Icons.person, color: Colors.grey, size: 30),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.camera_alt, color: Colors.red[400]),
                          label: Text(
                            'Upload Photo',
                            style: TextStyle(color: Colors.red[400]),
                          ),
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.grey[300]!)
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                _buildTextField(label: 'Referral code (Optional)', hint: 'Enter referral code'),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DocumentChecklistScreen()));
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to avoid repetitive code for form fields
  Widget _buildTextField({
    required String label,
    required String hint,
    Icon? suffixIcon,
    bool isEnabled = true,
    bool isReadOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF616161), fontSize: 14)),
          const SizedBox(height: 8),
          TextFormField(
            enabled: isEnabled,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[400]),
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: isEnabled ? Colors.white : Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.amber[700]!),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}