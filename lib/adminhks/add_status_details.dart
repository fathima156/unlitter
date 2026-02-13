import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddHouseDetailsPage extends StatefulWidget {
  const AddHouseDetailsPage({super.key});

  @override
  State<AddHouseDetailsPage> createState() => _AddHouseDetailsPageState();
}

class _AddHouseDetailsPageState extends State<AddHouseDetailsPage> {
  // 1. DATA GATHERING CONTROLLERS
  String? _selectedHouse;
  String _paymentStatus = 'Unpaid';
  DateTime _selectedDate = DateTime.now();
  String _selectedMonth = DateFormat('MMMM').format(DateTime.now());

  // Mock List - In 2026, this will fetch from 'users' collection
  final List<String> _houses = [
    'H-101 (Rahul)',
    'H-102 (Sita)',
    'H-105 (Ali)',
    'H-110 (Binu)',
  ];
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _saveDetails() {
    // CAPTURING THE FINAL DATA
    String formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);

    print("Saving Record: House: $_selectedHouse");
    print("Month: $_selectedMonth | Status: $_paymentStatus");
    print("Collection Date: $formattedDate");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Record Updated Successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Collection Details"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HOUSE SEARCH/SELECT
            const Text(
              "Search & Select House",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _selectedHouse,
              items: _houses
                  .map((h) => DropdownMenuItem(value: h, child: Text(h)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedHouse = val),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),

            // PAYMENT STATUS
            const Text(
              "Payment Status",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio(
                  value: 'Paid',
                  groupValue: _paymentStatus,
                  onChanged: (v) => setState(() => _paymentStatus = v!),
                ),
                const Text("Paid"),
                Radio(
                  value: 'Unpaid',
                  groupValue: _paymentStatus,
                  onChanged: (v) => setState(() => _paymentStatus = v!),
                ),
                const Text("Unpaid"),
              ],
            ),
            const SizedBox(height: 20),

            // MONTH SELECTION
            const Text(
              "For Month",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _selectedMonth,
              items: _months
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedMonth = val!),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),

            // DATE PICKER
            const Text(
              "Collection Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              tileColor: Colors.grey[200],
              title: Text(DateFormat('dd-MM-yyyy').format(_selectedDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _saveDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text(
                "SAVE DETAILS",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
