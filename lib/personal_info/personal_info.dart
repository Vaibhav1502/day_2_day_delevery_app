import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../document_checklist_screen/document_checklist_screen.dart';


class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  late final List<Widget> _steps;

  // NEW: Add labels for the stepper
  final List<String> _stepLabels = ['Info', 'Contact', 'Details', 'Finish'];

  @override
  void initState() {
    super.initState();
    _steps = _buildSteps();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentStep < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DocumentChecklistScreen()),
      );
    }
  }

  void _goBack() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF9F9F9),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            if (_currentStep == 0) {
              Navigator.of(context).pop();
            } else {
              _goBack();
            }
          },
        ),
        title: const Text(
          'Personal information',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // UPDATED: This now calls the new stepper builder
            _buildStepIndicator(),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                children: _steps,
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  // --- START OF UPDATED/NEW METHODS ---

  /// Builds the custom stepper widget.
  Widget _buildStepIndicator() {
    // We build a list of widgets dynamically
    List<Widget> stepperItems = [];
    for (int i = 0; i < _stepLabels.length; i++) {
      // Add the step circle and label
      stepperItems.add(_buildStep(i));
      // Add a connector line if it's not the last step
      if (i < _stepLabels.length - 1) {
        stepperItems.add(_buildConnector(i));
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: stepperItems,
      ),
    );
  }

  /// Helper widget to build a single step (circle and label).
  Widget _buildStep(int index) {
    // A step is considered active if it's the current step or has been completed.
    bool isActive = index <= _currentStep;

    final Color activeColor = const Color(0xFFFBC609);
    final Color inactiveColor = Colors.grey.shade300;

    return Column(
      children: [
        // The numbered circle
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? activeColor : inactiveColor,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // The text label below the circle
        Text(
          _stepLabels[index],
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.black87 : Colors.grey.shade500,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  /// Helper widget to build the line connecting two steps.
  Widget _buildConnector(int index) {
    // The connector is active if the step before it has been completed.
    bool isCompleted = index < _currentStep;

    final Color activeColor = const Color(0xFFFBC609);
    final Color inactiveColor = Colors.grey.shade300;

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 2.0,
        color: isCompleted ? activeColor : inactiveColor,
      ),
    );
  }

  // --- END OF UPDATED/NEW METHODS ---

  // All methods below this line are unchanged
  List<Widget> _buildSteps() {
    return [
      _buildStepContent(
        title: 'Basic Information',
        description: 'Please provide your name and your father\'s name.',
        fields: [
          _buildTextField(label: 'First Name', hint: 'Please enter first name'),
          _buildTextField(label: 'Last Name', hint: 'Please enter last name'),
          _buildTextField(label: 'Father\'s Name', hint: 'Please enter father\'s name'),
        ],
      ),
      _buildStepContent(
        title: 'Contact Details',
        description: 'Let us know the best ways to reach you.',
        fields: [
          _buildTextField(label: 'Primary mobile number', hint: '+91 9999988888', isEnabled: false),
          _buildTextField(label: 'WhatsApp number', hint: '+91 9999988888'),
          _buildTextField(label: 'Secondary mobile number (Optional)', hint: 'e.g. 9999999999'),
        ],
      ),
      _buildStepContent(
        title: 'Location Detail',
        description: 'Your date of birth, location, and other essential details.',
        fields: [
          _buildTextField(
            label: 'Date of birth', hint: 'dd-mm-yyyy',
            suffixIcon: Icon(Icons.calendar_today, color: Colors.red[400]),
          ),
          _buildTextField(label: 'Blood Group', hint: 'Enter blood group here'),
          _buildTextField(
            label: 'City', hint: 'e.g. Ahemdabad',
            suffixIcon: const Icon(Icons.arrow_forward_ios, size: 16), isReadOnly: true,
          ),
          _buildTextField(label: 'Enter complete address here', hint: 'Search address'),
        ],
      ),
      _buildStepContent(
        title: 'Final Details',
        description: 'Complete the final steps to finish your profile.',
        fields: [
          _buildTextField(
            label: 'Languages you know', hint: 'Select one or multiple',
            suffixIcon: const Icon(Icons.arrow_forward_ios, size: 16), isReadOnly: true,
          ),
          _buildProfilePictureUpload(),
          _buildTextField(label: 'Referral code (Optional)', hint: 'Enter referral code'),
        ],
      ),
    ];
  }

  Widget _buildStepContent({required String title, required String description, required List<Widget> fields}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(color: Colors.grey[600], fontSize: 15)),
            const SizedBox(height: 24),
            ...fields,
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _goBack,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  side: BorderSide(color: Colors.grey[400]!),
                ),
                child: const Text('Back', style: TextStyle(color: Colors.black54, fontSize: 16)),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _goNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBC609),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 0,
              ),
              child: Text(
                _currentStep == _steps.length - 1 ? 'Submit' : 'Next',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePictureUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
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
                  label: Text('Upload Photo', style: TextStyle(color: Colors.red[400])),
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
        const SizedBox(height: 16)
      ],
    );
  }

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