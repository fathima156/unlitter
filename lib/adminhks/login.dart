import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isOTPSent = false;
  String _otpCode = "";

  // 1. Function to simulate sending OTP
  void _sendOTP() async {
    if (_phoneController.text.length == 10) {
      setState(() => _isOTPSent = true);
      // This tells the phone to start "listening" for the incoming SMS
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
    SmsAutoFill().unregisterListener(); // Clean up the listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PinFieldAutoFill(
      codeLength: 6,
      onCodeChanged: (code) {
        setState(() {
          _otpCode = code ?? "";
        });

        if (code != null && code.length == 6) {
          print("OTP entered: $code");
        }
      },
    );
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

            // Phone Number Input
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

            // OTP Input (Visible after Send OTP is clicked)
            if (_isOTPSent) ...[
              const Text(
                "Enter the 6-digit code",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              // THE MAGIC WIDGET: It fills automatically when SMS arrives!
              PinFieldAutoFill(
                codeLength: 6,
                onCodeChanged: (code) {
                  if (code!.length == 6) {
                    _otpCode = code;
                    // Logic to verify code and check ROLE (Admin/User) goes here
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
