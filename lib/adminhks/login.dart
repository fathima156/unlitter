import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:unlitter/adminhks/register_admin.dart';

// IMPORTANT: Ensure these file paths match your project structure
// IMPORTANT: Ensure these file paths match your project structure

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isOTPSent = false;

  void verifyOTP() {
    // Replace this with your actual OTP logic check
    String enteredOtp = "123456";

    if (enteredOtp == "123456") {
      // Navigate to the registration page you provided
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HKSRegistrationPage(
            phoneNumber: _phoneController.text, // Passing the phone number
          ),
        ),
      );
    }
  }

  void _sendOTP() async {
    // Simulate OTP sending
    if (_phoneController.text.length == 10) {
      String? signature = await SmsAutoFill().getAppSignature;
      debugPrint("Sending OTP to ${_phoneController.text}. Signature: $signature");
      setState(() {
        _isOTPSent = true;
      });
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
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

              if (_isOTPSent) ...[
                const Text(
                  "Enter the 6-digit code",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                PinFieldAutoFill(
                  codeLength: 6,
                  // This property must be inside the PinFieldAutoFill constructor
                  onCodeChanged: (code) {
                    if (code != null && code.length == 6) {
                      // setState(() => _otpCode = code); // Unused

                      // bool isRegisteredAdmin = false; // Set to true to test dashboard

                      // Directly navigate to registration for now (fixing dead code warning)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HKSRegistrationPage(
                            phoneNumber: _phoneController.text,
                          ),
                        ),
                      );
                    }
                  },
                  //otp style
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder: FixedColorBuilder(Colors.green),
                    gapSpace: 10,
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
      ),
    );
  }
}
