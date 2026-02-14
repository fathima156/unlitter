import 'package:flutter/material.dart';

class HouseRegistrationPage extends StatefulWidget {
  const HouseRegistrationPage({super.key});

  @override
  State<HouseRegistrationPage> createState() => _HouseRegistrationPageState();
}

class _HouseRegistrationPageState extends State<HouseRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture user input
  final TextEditingController panchayatController = TextEditingController();
  final TextEditingController wardController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    panchayatController.dispose();
    wardController.dispose();
    houseNoController.dispose();
    houseNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("House Registration"),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Register New Household",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),

              // 1. Panchayat
              _buildTextField(
                controller: panchayatController,
                label: "Panchayat/Municipality",
                icon: Icons.location_city,
              ),

              // 2. Ward Number
              _buildTextField(
                controller: wardController,
                label: "Ward Number",
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
              ),

              // 3. House Number
              _buildTextField(
                controller: houseNoController,
                label: "House Number",
                icon: Icons.home_work,
              ),

              // 4. House Name
              _buildTextField(
                controller: houseNameController,
                label: "Address",
                icon: Icons.home,
              ),

              // 5. Phone Number
              _buildTextField(
                controller: phoneController,
                label: "Phone Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Logic to save to database goes here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Processing Registration..."),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "REGISTER HOUSE",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to keep code clean
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.green),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }
}
