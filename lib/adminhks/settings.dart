import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.green[700],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "App Preferences",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: const Text("English (Default)"),
            onTap: () {},
          ),
          SwitchListTile(
            title: const Text("Push Notifications"),
            value: true,
            onChanged: (val) {},
            secondary: const Icon(Icons.notifications),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_center),
            title: const Text("Help & Support"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              // Add Logout Logic
            },
          ),
        ],
      ),
    );
  }
}
