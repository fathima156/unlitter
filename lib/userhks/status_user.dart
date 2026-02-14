import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatusViewPage extends StatelessWidget {
  const StatusViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for display
    int totalHouses = 150;
    int visitedHouses = 85;
    double progress = visitedHouses / totalHouses;
    int pendingHouses = totalHouses - visitedHouses;
    String totalFee = "4,250";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Collection Status"),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. Progress Circle
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 12.0,
              percent: progress,
              center: Text(
                "${(progress * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              footer: const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  "Today's Progress",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.green,
            ),

            const SizedBox(height: 30),

            // 2. Summary Cards Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _buildStatusCard(
                  "Total Houses",
                  totalHouses.toString(),
                  Icons.home,
                  Colors.blue,
                ),
                _buildStatusCard(
                  "Visited",
                  visitedHouses.toString(),
                  Icons.check_circle,
                  Colors.green,
                ),
                _buildStatusCard(
                  "Pending",
                  pendingHouses.toString(),
                  Icons.pending,
                  Colors.orange,
                ),
                _buildStatusCard(
                  "Fees Collected",
                  "₹$totalFee",
                  Icons.payments,
                  Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 3. Detailed List View Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to a detailed list of houses
              },
              icon: const Icon(Icons.list_alt),
              label: const Text("View Detailed House List"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for status cards
  Widget _buildStatusCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
