import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:trail2/common/color_extension.dart';
import 'package:trail2/view/add_subscription/add_subscription_view.dart';
import 'package:trail2/view/spending_budgets/spending_budgets_view.dart'; // This is actually ProfileView
import 'package:trail2/view/calender/calender_view.dart';
import 'package:trail2/view/card/cards_view.dart';
import 'package:trail2/view/home/home_view.dart';
import 'package:trail2/view_models/home_view_model.dart'; // Import HomeViewModel
import 'package:trail2/models/subscription.dart'; // Import Subscription model


class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => MainTabViewState();
}

class MainTabViewState extends State<MainTabView> {
  int selectTab = 0;

  // Removed GlobalKey<HomeViewState> homeViewKey; as we will use Provider

  final List<Widget> _tabs = [];

  @override
  void initState() {
    super.initState();
    // Initialize _tabs without a GlobalKey for HomeView
    _tabs.addAll([
      const HomeView(), // HomeView no longer needs a key for addSubscription
      const ProfileView(), // Renamed from SpendingBudgetsView in snippets
      const CalenderView(),
      const CardsView(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[selectTab],
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: TColor.white,
        notchMargin: 12,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            _buildTabButton("assets/img/home.png", 0, "Home"),
            _buildTabButton("assets/img/budgets.png", 1, "Budgets"), // Assuming ProfileView is for Budgets
            _buildTabButton("assets/img/calendar.png", 2, "Calendar"),
            _buildTabButton("assets/img/creditcards.png", 3, "Cards"),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColor.primary,
        shape: const CircleBorder(),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddSubScriptionView()),
          );

          if (result != null && result is Subscription) { // Check for Subscription type
            // Access the HomeViewModel using Provider
            final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
            homeViewModel.addSubscription(result); // Pass the Subscription object
          }
        },
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }

  Widget _buildTabButton(String iconPath, int index, String label) {
    final isSelected = selectTab == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectTab = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Image.asset(
              iconPath,
              width: 25,
              height: 25,
              color: isSelected ? TColor.primary : TColor.gray,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? TColor.primary : TColor.gray,
                fontSize: 11,
              ),
            )
          ],
        ),
      ),
    );
  }
}