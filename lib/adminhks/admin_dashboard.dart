import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // 1. TOP NAVIGATION BAR (Account & Settings)
      appBar: AppBar(
        title: const Text("HKS Admin Console"),
        backgroundColor: Colors.green[700],
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showSettings(context),
          ),
          GestureDetector(
            onTap: () => _showAccountProfile(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.green),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Operational Menus",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 2. THE MENU GRID
            GridView.count(
              shrinkWrap:
                  true, // Crucial for using Grid inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.1,
              children: [
                _buildMenuCard(
                  context,
                  "Notifications",
                  "Enter alerts",
                  Icons.send_rounded,
                  Colors.blue,
                  const SentNotificationPage(),
                ),
                _buildMenuCard(
                  context,
                  "Register User",
                  "New household",
                  Icons.person_add_alt_1,
                  Colors.orange,
                  const RegisterUserPage(),
                ),
                _buildMenuCard(
                  context,
                  "House Status",
                  "View / Add",
                  Icons.fact_check_outlined,
                  Colors.green,
                  const HouseFinancePage(),
                ),
                _buildMenuCard(
                  context,
                  "Concerns",
                  "Poor segregation",
                  Icons.warning_amber_rounded,
                  Colors.redAccent,
                  const AdminConcernsPage(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 3. REUSABLE MENU CARD COMPONENT
  Widget _buildMenuCard(
    BuildContext context,
    String title,
    String sub,
    IconData icon,
    Color color,
    Widget page,
  ) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(sub, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // 4. POPUP FOR ACCOUNT
  void _showAccountProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 15),
            const Text(
              "Panchayat Secretary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Admin ID: HKS-9921"),
            const Divider(height: 40),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showSettings(BuildContext context) {
    // Navigate to settings logic
  }
}
