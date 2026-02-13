import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HouseFinancePage extends StatefulWidget {
  const HouseFinancePage({super.key});

  @override
  State<HouseFinancePage> createState() => _HouseFinancePageState();
}

class _HouseFinancePageState extends State<HouseFinancePage> {
  // Filters
  String _selectedWard = 'All';
  String _selectedMonth = DateFormat('MMMM').format(DateTime.now());

  final List<String> _wards = ['All', 'Ward 1', 'Ward 2', 'Ward 3', 'Ward 4'];
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // Mock Data
  final List<Map<String, dynamic>> _allData = [
    {
      'house': '101',
      'name': 'Adarsh',
      'ward': 'Ward 1',
      'month': 'February',
      'status': 'Paid',
      'date': '10-02-2026',
    },
    {
      'house': '202',
      'name': 'Binu',
      'ward': 'Ward 2',
      'month': 'February',
      'status': 'Unpaid',
      'date': '-',
    },
    {
      'house': '105',
      'name': 'Chitra',
      'ward': 'Ward 1',
      'month': 'January',
      'status': 'Paid',
      'date': '15-01-2026',
    },
  ];

  void _addNewDetails() {
    // Logic to open a dialog or navigate to your 'Register User' or 'Add Payment' form
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Redirecting to Entry Form...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter Logic
    List<Map<String, dynamic>> filteredList = _allData.where((item) {
      bool wardMatch = _selectedWard == 'All' || item['ward'] == _selectedWard;
      bool monthMatch = item['month'] == _selectedMonth;
      return wardMatch && monthMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Finance & Status"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // FILTER SECTION
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green[50],
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedWard,
                    isExpanded: true,
                    items: _wards
                        .map((w) => DropdownMenuItem(value: w, child: Text(w)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedWard = val!),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedMonth,
                    isExpanded: true,
                    items: _months
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedMonth = val!),
                  ),
                ),
              ],
            ),
          ),

          // LIST SECTION
          Expanded(
            child: filteredList.isEmpty
                ? const Center(
                    child: Text("No records found for this selection"),
                  )
                : ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(child: Text(item['house'])),
                          title: Text("${item['name']} (${item['house']})"),
                          subtitle: Text("Date: ${item['date']}"),
                          trailing: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: item['status'] == 'Paid'
                                  ? Colors.green[100]
                                  : Colors.red[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              item['status'],
                              style: TextStyle(
                                color: item['status'] == 'Paid'
                                    ? Colors.green[900]
                                    : Colors.red[900],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDetails,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
