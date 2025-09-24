import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AskForLeaveScreen extends StatefulWidget {
  const AskForLeaveScreen({super.key});

  @override
  State<AskForLeaveScreen> createState() => _AskForLeaveScreenState();
}

class _AskForLeaveScreenState extends State<AskForLeaveScreen> {
  // Controllers for the date fields
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF7F7F7),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: const Text(
            'Ask for leave',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  _buildNewApplicationForm(),
                  // Placeholder for the "My Application" tab
                  const Center(child: Text('My Applications List Goes Here')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return const TabBar(
      indicatorColor: Colors.amber,
      indicatorWeight: 3,
      labelColor: Colors.amber,
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
      tabs: [
        Tab(text: 'New Application'),
        Tab(text: 'My Application'),
      ],
    );
  }

  Widget _buildNewApplicationForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Request your leave details down below',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          _buildFormFieldRow('How many days?', _buildDropdownField(['1 Day', '2 Days', 'More than 2'])),
          _buildFormFieldRow('From', _buildDateField(_fromDateController)),
          _buildFormFieldRow('To', _buildDateField(_toDateController)),
          _buildFormFieldRow('Reason for leave', _buildDropdownField(['Sick Leave', 'Personal', 'Other'])),
          const SizedBox(height: 16),
          const Text('Comments', style: TextStyle(fontSize: 16, color: Colors.black87)),
          const SizedBox(height: 8),
          _buildCommentsField(),
          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildFormFieldRow(String label, Widget inputField) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87))),
          Expanded(flex: 3, child: inputField),
        ],
      ),
    );
  }

  Widget _buildDropdownField(List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: _inputDecoration(),
      hint: const Text('Select', style: TextStyle(color: Colors.grey)),
      items: items.map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (_) {},
    );
  }

  Widget _buildDateField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context, controller),
      decoration: _inputDecoration(
        hintText: 'dd/mm/yyyy',
        suffixIcon: Icon(Icons.calendar_today, color: Colors.red.shade300, size: 20),
      ),
    );
  }

  Widget _buildCommentsField() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      color: Colors.grey[400]!,
      strokeWidth: 1,
      dashPattern: const [6, 6],
      child: ClipRRect( // To ensure the child respects the border radius
        borderRadius: BorderRadius.circular(12),
        child: TextFormField(
          maxLines: 5,
          maxLength: 200,
          decoration: InputDecoration(
            hintText: 'Explain reason for leave in detail.',
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFDE188),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hintText, Widget? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red.shade100),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red.shade100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
    );
  }
}