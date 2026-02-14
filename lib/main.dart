import 'package:flutter/material.dart';

// Admin/Worker Folder Imports
import 'adminhks/login.dart'; // Admin Login
import 'adminhks/admin_dashboard.dart'; // Admin Dashboard
import 'adminhks/register_admin.dart'; // Admin Registration

// User/Household Folder Imports
import 'userhks/login_user.dart'; // User Login
import 'userhks/user_dashboard.dart'; // User Dashboard
import 'userhks/register_user.dart'; // User Registration

void main() {
  runApp(const UnlitterApp());
}

class UnlitterApp extends StatelessWidget {
  const UnlitterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haritha Karma Sena',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),

      // 1. SET THE STARTING PAGE
      // Change this to LoginUserPage() if you want the app to start for Residents
      home: const LoginPage(),

      // 2. DEFINE FIXED ROUTES
      // Only pages that DON'T require extra data (like phone numbers) go here
      routes: {
        // Admin Routes
        '/adminLogin': (context) => const LoginPage(),
        '/adminDashboard': (context) => const AdminDashboard(),

        // User Routes
        '/userLogin': (context) => const UserLoginPage(),
        '/userDashboard': (context) => const UserDashboard(),
      },
    );
  }
}
