import 'package:flutter/material.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. TOP PROFILE SECTION
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 60, color: Colors.green),
                ),
                SizedBox(height: 15),
                Text(
                  "K. Rajesh Kumar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "HKS Secretary",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          // 2. INFORMATION CARDS
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _infoCard("Employee ID", "HKS-MNJ-2026-04", Icons.badge),
                _infoCard(
                  "Panchayat/Municipality",
                  "Manjeri Municipality",
                  Icons.location_city,
                ),
                _infoCard(
                  "Assigned Wards",
                  "Ward 1, Ward 2, Ward 5",
                  Icons.map,
                ),
                _infoCard("Phone Number", "+91 9876543210", Icons.phone),
                _infoCard("Email", "rajesh.hks@kerala.gov.in", Icons.email),

                const SizedBox(height: 20),

                // EDIT BUTTON
                ElevatedButton.icon(
                  onPressed: () {
                    // Logic to edit profile
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    "EDIT PROFILE",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // REUSABLE INFO CARD COMPONENT
  Widget _infoCard(String label, String value, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green[700]),
        title: Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
