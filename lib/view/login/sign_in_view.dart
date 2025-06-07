import 'package:flutter/material.dart';
import 'package:trail2/view/login/sign_up_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/primary_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../common_widget/secondary_boutton.dart';

import 'package:shared_preferences/shared_preferences.dart'; // For local storage
import 'package:http/http.dart' as http; // For API calls (if needed)
import '../home/home_view.dart';
import '../main_tab/main_tab_view.dart';// Import your HomeView

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isRemember = false;
  bool _isLoading = false; // Add a loading indicator

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: Stack( // Use a Stack to show loading indicator
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/img/app_logo.png",
                      width: media.width * 0.5, fit: BoxFit.contain),
                  const Spacer(),
                  RoundTextField(
                    title: "Login",
                    controller: txtEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundTextField(
                    title: "Password",
                    controller: txtPassword,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isRemember = !isRemember;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isRemember
                                  ? Icons.check_box_rounded
                                  : Icons.check_box_outline_blank_rounded,
                              size: 25,
                              color: TColor.gray50,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Remember me",
                              style: TextStyle(color: TColor.gray50, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement Forgot Password functionality
                          print("Forgot Password pressed");
                        },
                        child: Text(
                          "",
                          style: TextStyle(color: TColor.gray50, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PrimaryButton(
                    title: "Sign In",
                    onPressed: _signIn, // Call the sign-in function
                  ),
                  const Spacer(),
                  Text(
                    "if you don't have an account yet?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.white, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SecondaryButton(
                    title: "Sign up",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            if (_isLoading) // Show loading indicator
              Center(
                child: CircularProgressIndicator(
                  color: TColor.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      // 1. **Authentication Logic (Replace with your actual authentication)**
      //    This is a placeholder! You'll need to integrate with your backend
      //    or authentication provider (e.g., Firebase Auth).

      // Simulate a successful login after a short delay (remove this in production!)
      await Future.delayed(const Duration(seconds: 2));

      String email = txtEmail.text;
      String password = txtPassword.text;

      if (email == "sameerkingkhn2@gmail.com" && password == "password") {
        // Simulated successful login
        print("Simulated Login Successful");

        // 2. **Store Authentication Token (If Applicable)**
        //    If your backend returns a token, store it locally (e.g., SharedPreferences)
        //    so you can use it for subsequent API calls.
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', 'your_dummy_token'); // Replace with actual token

        // 3. **Navigate to HomeView**
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainTabView(), // Use your HomeView widget
          ),
        );
      } else {
        // Simulated failed login
        print("Simulated Login Failed");
        _showErrorSnackBar("Invalid email or password");
      }


      // Example: API call (replace with your actual API endpoint)
      // final response = await http.post(
      //   Uri.parse('your_login_api_endpoint'),
      //   body: {'email': txtEmail.text, 'password': txtPassword.text},
      // );

      // if (response.statusCode == 200) {
      //   // Successful login
      //   final responseData = json.decode(response.body);
      //   final authToken = responseData['token']; // Adjust based on your API response
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   await prefs.setString('authToken', authToken);

      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const HomeView(),
      //     ),
      //   );
      // } else {
      //   // Failed login
      //   print('Login failed: ${response.statusCode}');
      //   _showErrorSnackBar('Login failed. Please try again.');
      // }
    } catch (error) {
      print('Error during login: $error');
      _showErrorSnackBar('An error occurred. Please try again.');
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}