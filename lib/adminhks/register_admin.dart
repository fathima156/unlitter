import 'package:flutter/material.dart';

// 1. FIX: The main function needs a dummy phone number to run standalone
void main() => runApp(
  const MaterialApp(home: HKSRegistrationPage(phoneNumber: "9876543210")),
);

class HKSRegistrationPage extends StatefulWidget {
  final String phoneNumber;
  const HKSRegistrationPage({super.key, required this.phoneNumber});

  @override
  State<HKSRegistrationPage> createState() => _HKSRegistrationPageState();
}

class _HKSRegistrationPageState extends State<HKSRegistrationPage> {
  // 2. FIX: You must define _formKey here so the Form widget can find it
  final _formKey = GlobalKey<FormState>();

  // Data for Dropdowns
  final List<String> adminTypes = ['Panchayat', 'Municipality'];
  final Map<String, List<String>> locations = {
    'Panchayat': ['Pookottur', 'Pulpatta', 'Anakkayam', 'Kizhyattur'],
    'Municipality': ['Manjeri'],
  };
  final List<String> vehicleTypes = [
    'E-Auto',
    'Tractor',
    'Mini Truck',
    'Push Cart',
  ];

  // Selected Values
  String? selectedAdminType;
  String? selectedLocation;
  String? selectedVehicleType;

  // Controllers
  late TextEditingController phoneController;
  final nameController = TextEditingController();
  final vehicleNoController = TextEditingController();
  final aadhaarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize phone from the passed widget data
    phoneController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    // Clean up to save memory
    nameController.dispose();
    phoneController.dispose();
    vehicleNoController.dispose();
    aadhaarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HKS Worker Registration'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // This now works because we defined _formKey above
          child: Column(
            children: [
              // Admin Type Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Type',
                  prefixIcon: Icon(Icons.account_balance),
                ),
                items: adminTypes
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedAdminType = val;
                    selectedLocation = null;
                  });
                },
                validator: (val) => val == null ? 'Required' : null,
              ),

              const SizedBox(height: 15),

              // Mobile Number (Read-only)
              TextFormField(
                controller: phoneController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Verified Mobile',
                  prefixIcon: Icon(Icons.verified, color: Colors.green),
                ),
              ),

              const SizedBox(height: 15),

              // Name Field
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Worker Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) => val!.isEmpty ? 'Enter name' : null,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Logic to save
                  }
                },
                child: const Text(
                  'Register Worker',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
