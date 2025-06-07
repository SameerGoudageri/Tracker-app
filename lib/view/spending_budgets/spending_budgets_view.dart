import 'package:flutter/material.dart';
import 'package:trail2/common/color_extension.dart'; // Assuming you have this
import '../settings/settings_view.dart'; // Assuming you have this
import 'package:shared_preferences/shared_preferences.dart'; // For local storage
import 'package:http/http.dart' as http; // For API calls (if needed)
import 'package:trail2/view/login/sign_in_view.dart'; // Corrected (more concise) // Assuming you have a LoginView
import 'package:trail2/common_widget/budgets_row.dart'; // Assuming you have this

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String userName = "John Doe";
  String userEmail = "john.doe@example.com";
  String userLocation = "Bengaluru, India";
  String? _authToken; // Store auth token (nullable)
  int _subscriptionCount = 7;
  double _accountBalance = 5250.75;
  String _lastLogin = "2025-06-03 14:30";

  List budgetArr = [
    {
      "name": "Auto & Transport",
      "icon": "assets/img/auto_transport.png",
      "spend_amount": "2,500",
      "total_budget": "5,000",
      "left_amount": "2,500",
      "color": TColor.secondary
    },
    {
      "name": "Entertainment",
      "icon": "assets/img/entertainment.png",
      "spend_amount": "1,500",
      "total_budget": "3,000",
      "left_amount": "1,500",
      "color": TColor.primary
    },
    {
      "name": "Shopping",
      "icon": "assets/img/shopping.png",
      "spend_amount": "1,000",
      "total_budget": "2,000",
      "left_amount": "1,000",
      "color": TColor.secondaryG
    },
    {
      "name": "Food",
      "icon": "assets/img/restaurant.png",
      "spend_amount": "3,000",
      "total_budget": "4,000",
      "left_amount": "1,000",
      "color": TColor.secondary
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadAuthToken(); // Load token when the widget initializes
  }

  // Load the auth token from SharedPreferences
  Future<void> _loadAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _authToken = prefs.getString('authToken'); // Replace 'authToken' with your key
    });
  }

  // Save the auth token to SharedPreferences
  Future<void> _saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  // Remove the auth token from SharedPreferences (for logout)
  Future<void> _removeAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  // Simulate logout (replace with your actual logout logic)
  void _logout() async {
    setState(() {
      // Clear any local state related to the user
      userName = "";
      userEmail = "";
      userLocation = "";
      _subscriptionCount = 0;
      _accountBalance = 0.0;
      _lastLogin = "";
    });

    await _removeAuthToken(); // Remove token from local storage

    // Navigate back to the sign-in view
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInView()),
          (Route<dynamic> route) => false, // Remove all routes from the stack
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray, // Ensure scaffold background is consistent
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [TColor.primary, TColor.secondary], // Use your defined colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsView(),
                            ),
                          );
                        },
                        icon: Image.asset(
                          "assets/img/settings.png",
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Budget",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/img/notification.png",
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Where your money go",
                      style: TextStyle(
                        color: TColor.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Track your every transaction to know where your money is going.",
                      style: TextStyle(
                        color: TColor.gray30,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInfoCard(
                      media,
                      "Account Balance",
                      "₹${_accountBalance.toStringAsFixed(2)}",
                      TColor.primary,
                    ),
                    const SizedBox(height: 15),
                    _buildInfoCard(
                      media,
                      "Total Subscriptions",
                      "$_subscriptionCount",
                      TColor.secondary,
                    ),
                    const SizedBox(height: 15),
                    _buildInfoCard(
                      media,
                      "Last Login",
                      _lastLogin,
                      TColor.secondaryG,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Monthly Budgets",
                  style: TextStyle(
                    color: TColor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: budgetArr.length,
                itemBuilder: (context, index) {
                  var bObj = budgetArr[index] as Map? ?? {};
                  return BudgetsRow(
                    bObj: bObj,
                    onPressed: () {},
                  );
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _logout, // Call the logout function
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: TColor.gray30),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(color: TColor.gray30, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(Size media, String title, String value, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TColor.gray70.withOpacity(0.2), // Similar to home_view containers
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TColor.border.withOpacity(0.05), // Border from home_view
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: TColor.gray40, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}