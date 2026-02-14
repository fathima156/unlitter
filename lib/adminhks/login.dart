import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
// IMPORTANT: Import your dashboard file here
import 'admin_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isOTPSent = false;
  String _otpCode = "";

  void _sendOTP() async {
    if (_phoneController.text.length == 10) {
      setState(() => _isOTPSent = true);
      await SmsAutoFill().listenForCode();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("OTP Sent to your mobile")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 10-digit number")),
      );
    }
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.recycling, size: 80, color: Colors.green),
            const SizedBox(height: 10),
            const Text(
              "Haritha Karma Sena",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 40),

            // --- PHONE INPUT SECTION ---
            if (!_isOTPSent) ...[
              const Text(
                "Login to your account",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  prefixText: "+91 ",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Send OTP",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],

            // --- OTP INPUT SECTION ---
            if (_isOTPSent) ...[
              const Text(
                "Enter the 6-digit code",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              PinFieldAutoFill(
                codeLength: 6,
                onCodeChanged: (code) {
                  if (code != null && code.length == 6) {
                    setState(() => _otpCode = code);
                    // Navigate to Dashboard
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminDashboard(),
                      ),
                    );
                  }
                },
                decoration: BoxLooseDecoration(
                  strokeColorBuilder: FixedColorBuilder(Colors.green),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => setState(() => _isOTPSent = false),
                child: const Text("Change Phone Number"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
