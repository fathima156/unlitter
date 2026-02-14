import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _panchayatController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();

  bool _isOTPSent = false;

  void _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isOTPSent = true);
      // This triggers the listener for the Auto-fill OTP
      await SmsAutoFill().listenForCode();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP sent to verified mobile")),
      );
    }
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _phoneController.dispose();
    _panchayatController.dispose();
    _houseNoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getSignature();
  }

  void getSignature() async {
    // This prints the hash code to your VS Code / Android Studio console
    String? signature = await SmsAutoFill().getAppSignature;
    print("Your App Signature is: $signature");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.green[800]!,
              Colors.green[500]!,
              Colors.green[200]!,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Access your Waste Collection Status",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        if (!_isOTPSent) ...[
                          _buildInput(
                            controller: _panchayatController,
                            label: "Panchayat Name",
                            icon: Icons.location_city,
                          ),
                          const SizedBox(height: 20),
                          _buildInput(
                            controller: _houseNoController,
                            label: "House Number",
                            icon: Icons.home,
                          ),
                          const SizedBox(height: 20),
                          _buildInput(
                            controller: _phoneController,
                            label: "Registered Mobile",
                            icon: Icons.phone_android,
                            type: TextInputType.phone,
                          ),
                          const SizedBox(height: 40),
                          MaterialButton(
                            onPressed: _sendOTP,
                            height: 50,
                            minWidth: double.infinity,
                            color: Colors.green[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              "Verify & Send OTP",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        if (_isOTPSent) ...[
                          const Text(
                            "Enter 6-digit OTP sent to your phone",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          PinFieldAutoFill(
                            codeLength: 6,
                            onCodeChanged: (val) {
                              if (val?.length == 6) {
                                // Navigate to User Status View
                              }
                            },
                            decoration: UnderlineDecoration(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              colorBuilder: FixedColorBuilder(
                                Colors.green[700]!,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextButton(
                            onPressed: () => setState(() => _isOTPSent = false),
                            child: const Text(
                              "Change Details",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(225, 95, 27, .3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.green),
        ),
        validator: (val) => val!.isEmpty ? "Required" : null,
      ),
    );
  }
}
