import 'package:flutter/material.dart';
import 'register_user.dart';
import 'sent_notification.dart';
// FIX: Ensure this matches the class name in your first code block
import 'add_status_details.dart';
import 'concern_page.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("HKS Admin Panel"),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            // WORKFLOW FIX: Returns to role selection
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              '/landing',
              (r) => false,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _menuCard(
                  context,
                  "Register User",
                  Icons.person_add,
                  Colors.blue,
                  const RegisterUserPage(),
                ),
                _menuCard(
                  context,
                  "Notifications",
                  Icons.campaign,
                  Colors.orange,
                  const SentNotificationPage(),
                ),
                // FIX: Pointing to the Collection Details page you shared
                _menuCard(
                  context,
                  "Update Collection",
                  Icons.fact_check,
                  Colors.green,
                  const AddHouseDetailsPage(),
                ),
                _menuCard(
                  context,
                  "Log Concern",
                  Icons.report_problem,
                  Colors.red,
                  const AdminConcernsPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.admin_panel_settings, size: 30, color: Colors.green),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Welcome Admin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Manage your HKS activities",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
