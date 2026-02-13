import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'adminhks/register_admin.dart'; // We will link your forms here later

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We'll initialize Firebase here once you set up your project 📂
  // await Firebase.initializeApp();
  runApp(const HKSApp());
}

class HKSApp extends StatelessWidget {
  const HKSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haritha Karma Sena',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const AuthWrapper(), // This decides the first screen
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    // While testing, just return the page you are working on!
    return const HKSRegistrationPage();
  }
}

class PlaceholderLogin extends StatelessWidget {
  const PlaceholderLogin({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Login Screen Placeholder')));
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Admin Dashboard')));
}

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('User Dashboard')));
}
