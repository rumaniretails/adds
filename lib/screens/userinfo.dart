import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:templering/screens/home.dart';

class UserInfoFormScreen extends StatefulWidget {
  const UserInfoFormScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoFormScreen> createState() => _UserInfoFormScreenState();
}

class _UserInfoFormScreenState extends State<UserInfoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenUserForm', true);
      await prefs.setString('userName', nameController.text);
      await prefs.setString('userEmail', emailController.text);
      await prefs.setString('userMobile', mobileController.text);

      Get.off(() => const HomeScreen());
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType? inputType,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        validator: validator,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.teal),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Let’s get to know you!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Fill out the information below to continue",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      label: "Full Name",
                      controller: nameController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                      icon: Icons.person,
                    ),
                    _buildTextField(
                      label: "Email Address",
                      controller: emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your email' : null,
                      inputType: TextInputType.emailAddress,
                      icon: Icons.email,
                    ),
                    _buildTextField(
                      label: "Mobile Number",
                      controller: mobileController,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your mobile number'
                          : null,
                      inputType: TextInputType.phone,
                      icon: Icons.phone,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _saveUserData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
