import 'package:flutter/material.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  // Controllers for each required field
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _panchayatController = TextEditingController();
  final _wardController = TextEditingController();
  final _addressController = TextEditingController();
  final _houseNoController = TextEditingController();

  void _submitData() {
    // Logic to save this data to Firebase Firestore goes here
    debugPrint("Registering User: ${_nameController.text}");
    debugPrint(
      "Panchayat: ${_panchayatController.text}, Ward: ${_wardController.text}",
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User Registered Successfully!")),
    );
    Navigator.pop(context); // Go back to Admin Menu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Citizen"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        // Allows scrolling if keyboard pops up
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_nameController, "Full Name", Icons.person),
            _buildTextField(
              _phoneController,
              "Phone Number",
              Icons.phone,
              inputType: TextInputType.phone,
            ),
            _buildTextField(
              _panchayatController,
              "Panchayat",
              Icons.location_city,
            ),
            _buildTextField(
              _wardController,
              "Ward Number",
              Icons.door_front_door,
              inputType: TextInputType.number,
            ),
            _buildTextField(_houseNoController, "House Number", Icons.home),
            _buildTextField(
              _addressController,
              "Address",
              Icons.map,
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Register User",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to keep the code clean
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.green),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
