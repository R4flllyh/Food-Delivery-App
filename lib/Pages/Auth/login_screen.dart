import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/Auth/signup_screen.dart';
import 'package:food_delivery/Pages/Screen/onboarding_screen.dart';
import 'package:food_delivery/Service/auth_service.dart';
import 'package:food_delivery/Widgets/page_button.dart';
import 'package:food_delivery/Widgets/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controller for email
  TextEditingController emailController = TextEditingController();
  // controller for password
  TextEditingController passwordController = TextEditingController();

  // AuthService
  final AuthService _authService = AuthService();
  bool isLoading = false;
  bool isPasswordHidden = true;

  void _logIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    // Validate email and password
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    final result = await _authService.login(email, password);
    if (result == null) {
      // Success Case
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    } else {
      // Error Case
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Signup failed: $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset(
              'assets/login.jpg',
              width: double.maxFinite,
              height: 500,
              fit: BoxFit.contain,
            ),

            // input field for email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                ),
              ),
            ),
            SizedBox(height: 20),
            // input field for password
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                ),
              ),
              obscureText: isPasswordHidden,
            ),
            SizedBox(height: 50),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                  width: double.maxFinite,
                  child: PageButton(buttonText: "Login", onTap: _logIn),
                ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ", style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignupScreen()),
                    );
                  },
                  child: Text(
                    "Signup here",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
