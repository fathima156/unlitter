import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminConcernsPage extends StatefulWidget {
  const AdminConcernsPage({super.key});

  @override
  State<AdminConcernsPage> createState() => _AdminConcernsPageState();
}

class _AdminConcernsPageState extends State<AdminConcernsPage> {
  String? _selectedWard;
  String? _selectedHouse;
  final TextEditingController _concernController = TextEditingController();

  // mock data for ward and houses
  final List<String> _wards = ['Ward 1', 'Ward 2', 'Ward 3', 'Ward 4'];

  // In a real app, this map would be filtered based on the selected ward
  final Map<String, List<String>> _wardHouses = {
    'Ward 1': ['101 (Rahul)', '102 (Sita)', '103 (Anil)'],
    'Ward 2': ['201 (Binu)', '202 (John)', '205 (Mary)'],
  };

  // Predefined common concerns for quick selection
  final List<String> _commonConcerns = [
    'Poor Waste Segregation',
    'House Locked / No Access',
    'Incomplete Payment',
    'Misbehavior with Worker',
    'Excessive Waste Volume',
  ];

  void _submitConcern() {
    if (_selectedWard == null ||
        _selectedHouse == null ||
        _concernController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all details")));
      return;
    }

    // Capture the exact moment the concern was raised
    String timestamp = DateFormat(
      'dd-MM-yyyy | hh:mm a',
    ).format(DateTime.now());

    print("Logging Concern for $_selectedHouse in $_selectedWard");
    print("Concern: ${_concernController.text}");
    print("Time: $timestamp");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Concern Logged Successfully!")),
    );

    // Clear  form
    _concernController.clear();
    setState(() {
      _selectedHouse = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log User Concern"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SELECT WARD
            const Text(
              "Step 1: Select Ward",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _selectedWard,
              hint: const Text("Choose Ward"),
              items: _wards
                  .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                  .toList(),
              onChanged: (val) => setState(() {
                _selectedWard = val;
                _selectedHouse = null; // Reset house when ward changes
              }),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),

            // 2. SELECT HOUSE (Enabled only after Ward is selected)
            const Text(
              "Step 2: Select House Number",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _selectedHouse,
              hint: const Text("Choose House"),
              disabledHint: const Text("Select Ward First"),
              items: _selectedWard == null
                  ? []
                  : _wardHouses[_selectedWard]!
                        .map((h) => DropdownMenuItem(value: h, child: Text(h)))
                        .toList(),
              onChanged: (val) => setState(() => _selectedHouse = val),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),

            // 3. QUICK CONCERNS
            const Text(
              "Quick Select Concern",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: _commonConcerns
                  .map(
                    (concern) => ActionChip(
                      label: Text(concern),
                      onPressed: () =>
                          setState(() => _concernController.text = concern),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 15),

            // 4. DETAILED CONCERN
            const Text(
              "Step 3: Concern Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _concernController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Type specific details here...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitConcern,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text(
                "LOG CONCERN",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
