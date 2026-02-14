import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SentNotificationPage extends StatefulWidget {
  const SentNotificationPage({super.key});

  @override
  State<SentNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SentNotificationPage> {
  final TextEditingController _specController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedWard = 'Ward 1';

  final List<String> _wards = [
    'Ward 1',
    'Ward 2',
    'Ward 3',
    'Ward 4',
    'Ward 5',
  ];

  // Function to pick a date
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _sendNotification() {
    // 1. CAPTURE CURRENT DATE/TIME OF THE ACTION
    DateTime now = DateTime.now();
    String sentAtDate = DateFormat('dd-MM-yyyy').format(now);
    String sentAtTime = DateFormat('hh:mm a').format(now);

    // 2. GET THE SCHEDULED PICKUP DATE
    String pickupDate = _selectedDate != null
        ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
        : 'Not set';

    // 3. CONSOLIDATE DATA FOR FIREBASE/UI
    debugPrint("Action: Notification Sent at $sentAtDate at $sentAtTime");
    debugPrint("Target: $_selectedWard");
    debugPrint("Scheduled Pickup: $pickupDate");
    debugPrint("Waste Type: ${_specController.text}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Broadcast sent to $_selectedWard!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule Collection"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Waste Specification (e.g., Plastic only)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _specController,
              decoration: const InputDecoration(hintText: "Enter details..."),
            ),
            const SizedBox(height: 20),

            const Text(
              "Select Ward",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedWard,
              isExpanded: true,
              items: _wards
                  .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedWard = val!),
            ),
            const SizedBox(height: 20),

            const Text(
              "Pickup Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? "No date chosen"
                      : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _pickDate(context),
                  child: const Text("Pick Date"),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _sendNotification,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Send to Users",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
