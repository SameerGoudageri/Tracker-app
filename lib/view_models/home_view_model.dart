import 'package:flutter/material.dart';
import 'package:trail2/models/subscription.dart'; // Import your Subscription model

class HomeViewModel extends ChangeNotifier {
  final List<Subscription> _subscriptions = [
    // Initial dummy data
    Subscription(
      id: "1",
      name: "Spotify",
      icon: "assets/img/spotify_logo.png",
      price: 5.99,
      billingCycle: "Monthly",
      nextBillDate: DateTime.now().add(const Duration(days: 5)),
      category: "Entertainment",
      displayColor: Colors.green,
    ),
    Subscription(
      id: "2",
      name: "YouTube Premium",
      icon: "assets/img/youtube_logo.png",
      price: 18.99,
      billingCycle: "Monthly",
      nextBillDate: DateTime.now().add(const Duration(days: 10)),
      category: "Entertainment",
      displayColor: Colors.red,
    ),
    Subscription(
      id: "3",
      name: "Microsoft OneDrive",
      icon: "assets/img/onedrive_logo.png",
      price: 29.99,
      billingCycle: "Yearly",
      nextBillDate: DateTime.now().add(const Duration(days: 60)),
      category: "Utilities",
      displayColor: Colors.blue,
    ),
    Subscription(
      id: "4",
      name: "NetFlix",
      icon: "assets/img/netflix_logo.png",
      price: 15.00,
      billingCycle: "Monthly",
      nextBillDate: DateTime.now().add(const Duration(days: 20)),
      category: "Entertainment",
      displayColor: Colors.purple,
    ),
  ];

  List<Subscription> get subscriptions => _subscriptions;

  void addSubscription(Subscription newSubscription) {
    _subscriptions.add(newSubscription);
    notifyListeners();
  }

  void removeSubscription(String id) {
    _subscriptions.removeWhere((sub) => sub.id == id);
    notifyListeners();
  }
}