import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'adminhks/login.dart';
import 'adminhks/admin_dashboard.dart';
import 'userhks/login_user.dart';
import 'userhks/user_dashboard.dart';

void main() => runApp(const UnlitterApp());

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
      home: const LandingPage(), // Start here
      routes: {
        '/landing': (context) => const LandingPage(),
        '/adminLogin': (context) => const LoginPage(),
        '/userLogin': (context) => const UserLoginPage(),
        '/adminDashboard': (context) => const AdminDashboard(),
        '/userDashboard': (context) => const UserDashboard(),
      },
    );
  }
}
