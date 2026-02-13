import 'package:flutter/material.dart';

class PaymentStatusPage extends StatefulWidget {
  const PaymentStatusPage({super.key});

  @override
  State<PaymentStatusPage> createState() => _PaymentStatusPageState();
}

class _PaymentStatusPageState extends State<PaymentStatusPage> {
  // Mock Data: to Replace with firebase stream later
  final List<Map<String, dynamic>> _allRecords = [
    {
      'house': 'H-101',
      'name': 'Adarsh',
      'ward': 'Ward 1',
      'status': 'Paid',
      'month': 'January',
      'date': '12-01-2026',
    },
    {
      'house': 'H-102',
      'name': 'Binu',
      'ward': 'Ward 2',
      'status': 'Unpaid',
      'month': 'January',
      'date': '-',
    },
    {
      'house': 'H-205',
      'name': 'Chitra',
      'ward': 'Ward 1',
      'status': 'Paid',
      'month': 'February',
      'date': '05-02-2026',
    },
  ];

  String _selectedWard = 'All';
  String _selectedMonth = 'All';
  String _searchQuery = "";

  final List<String> _wards = [
    'All',
    'Ward 1',
    'Ward 2',
    'Ward 3',
    'Ward 4',
    'Ward 5',
  ];
  final List<String> _months = [
    'All',
    'January',
    'February',
    'March',
    'April',
    'May',
  ];

  @override
  Widget build(BuildContext context) {
    // Logic to filter the list based on werd, ,month, and search Query
    List<Map<String, dynamic>> filteredRecords = _allRecords.where((record) {
      bool matchesWard =
          _selectedWard == 'All' || record['ward'] == _selectedWard;
      bool matchesMonth =
          _selectedMonth == 'All' || record['month'] == _selectedMonth;
      bool matchesSearch =
          record['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record['house'].contains(_searchQuery);
      return matchesWard && matchesMonth && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Status"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // 1. Search and Filter Header
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: const InputDecoration(
                    hintText: "Search by Name or House No...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedWard,
                        decoration: const InputDecoration(labelText: "Ward"),
                        items: _wards
                            .map(
                              (w) => DropdownMenuItem(value: w, child: Text(w)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedWard = val!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedMonth,
                        decoration: const InputDecoration(labelText: "Month"),
                        items: _months
                            .map(
                              (m) => DropdownMenuItem(value: m, child: Text(m)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedMonth = val!),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Data Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('House / Name')),
                    DataColumn(label: Text('Month')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Date Paid')),
                  ],
                  rows: filteredRecords
                      .map(
                        (record) => DataRow(
                          cells: [
                            DataCell(
                              Text(
                                "${record['house']}\n${record['name']}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            DataCell(Text(record['month'])),
                            DataCell(
                              Icon(
                                record['status'] == 'Paid'
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: record['status'] == 'Paid'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            DataCell(Text(record['date'])),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
