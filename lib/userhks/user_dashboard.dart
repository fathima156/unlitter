import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("HKS User Portal"),
        backgroundColor: Colors.green[700],
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. DYNAMIC NOTIFICATION CARD
            _buildNotificationCard(),

            const SizedBox(height: 20),
            const Text(
              "Your Collection Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 2. STATS ROW
            Row(
              children: [
                _buildStatCard(
                  "Last Visit",
                  "Feb 10",
                  Icons.event_available,
                  Colors.blue,
                ),
                const SizedBox(width: 10),
                _buildStatCard(
                  "Dues",
                  "₹50",
                  Icons.account_balance_wallet,
                  Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 3. COLLECTION PROGRESS
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Text(
                    "Monthly Collection Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  LinearPercentIndicator(
                    lineHeight: 20.0,
                    percent: 1.0, // Set based on status
                    center: const Text(
                      "Collected",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    barRadius: const Radius.circular(10),
                    progressColor: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4. ACTION BUTTONS
            _buildMenuTile(
              Icons.history,
              "Collection History",
              "View past dates and items",
            ),
            _buildMenuTile(
              Icons.payment,
              "Pay User Fee",
              "Online payment for this month",
            ),
            _buildMenuTile(
              Icons.report_problem_outlined,
              "Complaints",
              "Report missed collection",
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildNotificationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications_active, color: Colors.green[700]),
              const SizedBox(width: 8),
              const Text(
                "REMINDER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Collection in your ward (Ward 04) is Scheduled for TOMORROW.",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          const Text(
            "Please keep your segregated waste ready by 8:00 AM.",
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String title, String sub) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green[700]),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
