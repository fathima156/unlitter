import 'package:flutter/material.dart';

class UserReviewPage extends StatefulWidget {
  const UserReviewPage({super.key});

  @override
  State<UserReviewPage> createState() => _UserReviewPageState();
}

class _UserReviewPageState extends State<UserReviewPage> {
  double _userRating = 3.0;
  final TextEditingController _commentController = TextEditingController();
  String _selectedCategory = 'Regular Collection';

  final List<String> _categories = [
    'Regular Collection',
    'Behavior of Staff',
    'Timeliness',
    'Waste Segregation Help',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Feedback"),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How was your experience?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Your feedback helps us improve the HKS service."),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _userRating = index + 1.0;
                    });
                  },
                  icon: Icon(
                    index < _userRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),

            // 2. CATEGORY DROPDOWN
            const Text(
              "Review Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _categories.map((String category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),

            const SizedBox(height: 20),

            // 3. COMMENT BOX
            const Text(
              "Comments",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Tell us more about the service...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            // 4. SUBMIT BUTTON
            ElevatedButton(
              onPressed: () {
                // Logic to save review to Firebase
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Thank you for your feedback!")),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text(
                "SUBMIT REVIEW",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
