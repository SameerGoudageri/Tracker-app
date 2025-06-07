import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trail2/common/color_extension.dart';
import 'package:trail2/view_models/home_view_model.dart';
import 'package:trail2/models/subscription.dart'; // Make sure this path is correct
import 'package:intl/intl.dart';
import '../../common_widget/subscription_home_row.dart';
import '../../common_widget/upcoming_bill_row.dart';
import '../settings/settings_view.dart';
import '../subscription_info/subscription_info_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [TColor.primary, TColor.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Consumer<HomeViewModel>(
          builder: (context, homeViewModel, child) {
            final subscriptions = homeViewModel.subscriptions;
            final totalSpending = subscriptions.fold(0.0, (sum, item) => sum + item.price);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
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
                          "Subscriptions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // --- REMOVED: The IconButton for the notification icon ---
                        // IconButton(
                        //   onPressed: () {
                        //     // TODO: Implement notification functionality
                        //     print("Notification button pressed");
                        //   },
                        //   icon: Image.asset(
                        //     "assets/img/notification.png",
                        //     width: 25,
                        //     height: 25,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Spending",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 500),
                          tween: Tween<double>(begin: 0, end: totalSpending),
                          builder: (context, value, child) {
                            return Text(
                              "₹${value.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "This month",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Active Subscriptions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSubscriptionList(homeViewModel),
                  const SizedBox(height: 20),
                  Text(
                    "Upcoming Bills",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildUpcomingBills(homeViewModel),
                  const SizedBox(height: 130),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubscriptionList(HomeViewModel homeViewModel) {
    final subscriptions = homeViewModel.subscriptions;

    if (subscriptions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "No active subscriptions found.",
          style: TextStyle(color: Colors.white.withOpacity(0.8)),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final sub = subscriptions[index];
        return SubScriptionHomeRow(
          sObj: {
            "id": sub.id,
            "name": sub.name,
            "icon": sub.icon,
            "price": "₹${sub.price.toStringAsFixed(2)}",
            "billingCycle": sub.billingCycle,
            "nextBillDate": sub.nextBillDate.toIso8601String(),
            "category": sub.category,
            "displayColor": sub.displayColor,
          },
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => SubscriptionInfoView(
                  sObj: {
                    "id": sub.id,
                    "name": sub.name,
                    "icon": sub.icon,
                    "price": sub.price,
                    "billingCycle": sub.billingCycle,
                    "nextBillDate": sub.nextBillDate.toIso8601String(),
                    "category": sub.category,
                    "displayColor": sub.displayColor?.value ?? TColor.gray60.value,
                  },
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(position: offsetAnimation, child: child);
                },
              ),
            );
          },
          onDeletePressed: () {
            homeViewModel.removeSubscription(sub.id);
          },
        );
      },
    );
  }

  Widget _buildUpcomingBills(HomeViewModel homeViewModel) {
    final subscriptions = homeViewModel.subscriptions;

    if (subscriptions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "No upcoming bills found.",
          style: TextStyle(color: Colors.white.withOpacity(0.8)),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final sub = subscriptions[index];
        final Map<String, dynamic> upcomingBillMap = {
          "name": sub.name,
          "icon": sub.icon,
          "price": sub.price,
          "date": sub.nextBillDate.day.toString(),
          "month": DateFormat('MMM').format(sub.nextBillDate),
          "displayColor": sub.displayColor,
        };

        return UpcomingBillRow(
          sObj: upcomingBillMap,
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => SubscriptionInfoView(
                  sObj: {
                    "id": sub.id,
                    "name": sub.name,
                    "icon": sub.icon,
                    "price": sub.price,
                    "billingCycle": sub.billingCycle,
                    "nextBillDate": sub.nextBillDate.toIso8601String(),
                    "category": sub.category,
                    "displayColor": sub.displayColor?.value ?? TColor.gray60.value,
                  },
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(position: offsetAnimation, child: child);
                },
              ),
            );
          },
        );
      },
    );
  }
}