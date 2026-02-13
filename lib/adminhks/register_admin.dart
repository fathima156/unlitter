import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HKSRegistrationPage()));

class HKSRegistrationPage extends StatefulWidget {
  const HKSRegistrationPage({super.key});

  @override
  State<HKSRegistrationPage> createState() => _HKSRegistrationPageState();
}

class _HKSRegistrationPageState extends State<HKSRegistrationPage> {
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

  // Controllers to grab text data
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final vehicleNoController = TextEditingController();
  final aadhaarController = TextEditingController();

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
          key: _formKey,
          child: Column(
            children: [
              // 1. Admin Type (Panchayat or Municipality)
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
                    selectedLocation = null; // Reset location when type changes
                  });
                },
                validator: (val) => val == null ? 'Please select a type' : null,
              ),

              const SizedBox(height: 15),

              // 2. Specific Location (Dependent Dropdown)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Panchayat/Municipality',
                  prefixIcon: Icon(Icons.location_on),
                ),
                value: selectedLocation,
                items: (selectedAdminType == null)
                    ? []
                    : locations[selectedAdminType]!
                          .map(
                            (loc) =>
                                DropdownMenuItem(value: loc, child: Text(loc)),
                          )
                          .toList(),
                onChanged: (val) => setState(() => selectedLocation = val),
                validator: (val) =>
                    val == null ? 'Please select a location' : null,
              ),

              const SizedBox(height: 15),

              // 3. Name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Worker Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) => val!.isEmpty ? 'Enter full name' : null,
              ),

              const SizedBox(height: 15),

              // 4. Mobile Number
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (val) =>
                    val!.length != 10 ? 'Enter valid 10-digit number' : null,
              ),

              const SizedBox(height: 15),

              // 5. Vehicle Type Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Vehicle Type',
                  prefixIcon: Icon(Icons.local_shipping),
                ),
                items: vehicleTypes
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (val) => setState(() => selectedVehicleType = val),
                validator: (val) => val == null ? 'Select vehicle type' : null,
              ),

              const SizedBox(height: 15),

              // 6. Vehicle Number
              TextFormField(
                controller: vehicleNoController,
                decoration: const InputDecoration(
                  labelText: 'Vehicle Number',
                  hintText: 'KL-10-XX-0000',
                ),
                validator: (val) =>
                    val!.isEmpty ? 'Enter vehicle number' : null,
              ),

              const SizedBox(height: 15),

              // 7. Aadhaar Number
              TextFormField(
                controller: aadhaarController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Aadhaar Number',
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (val) =>
                    val!.length != 12 ? 'Aadhaar must be 12 digits' : null,
              ),

              const SizedBox(height: 30),

              // SUBMIT BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Logic to send data to your Backend/Database
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registering Worker...')),
                    );
                  }
                },
                child: const Text(
                  'Register Worker',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
