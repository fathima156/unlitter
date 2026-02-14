import 'package:flutter/material.dart';

import 'admin_dashboard.dart';

class HKSRegistrationPage extends StatefulWidget {
  final String phoneNumber;
  const HKSRegistrationPage({super.key, required this.phoneNumber});

  @override
  State<HKSRegistrationPage> createState() => _HKSRegistrationPageState();
}

class _HKSRegistrationPageState extends State<HKSRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> adminTypes = ['Panchayat', 'Municipality'];

  String? selectedAdminType;
  late TextEditingController phoneController;
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Registration'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                key: ValueKey(selectedAdminType),
                initialValue: selectedAdminType,
                decoration: const InputDecoration(labelText: 'Select Type'),
                items: adminTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => selectedAdminType = val),
              ),
              TextFormField(
                controller: phoneController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Verified Mobile',
                  prefixIcon: Icon(Icons.verified),
                ),
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Worker Name'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Final Step: Go to Dashboard
                    Navigator.pushReplacementNamed(context, '/adminDashboard');
                  }
                },
                child: const Text('Complete Registration'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // 1. Logic to save to database would go here

                    // 2. SUCCESS: Show a message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Account Created Successfully!"),
                      ),
                    );

                    // 3. NAVIGATION: Go to Dashboard and clear the registration screen from memory
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminDashboard(),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: const Text('Complete Registration'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
