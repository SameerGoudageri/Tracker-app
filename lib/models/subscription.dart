import 'package:flutter/material.dart'; // For Color, if you store it directly

class Subscription {
  final String id;
  final String name;
  final String icon; // Path to image asset
  final double price;
  final String billingCycle; // e.g., "Monthly", "Annually", "Weekly", "One-time"
  final DateTime nextBillDate;
  final String category; // e.g., "Streaming", "Utilities", "Software"
  final Color? displayColor; // Optional: for visual distinction

  Subscription({
    required this.id,
    required this.name,
    required this.icon,
    required this.price,
    required this.billingCycle,
    required this.nextBillDate,
    required this.category,
    this.displayColor,
  });

  // Factory constructor for creating a Subscription from a Map (e.g., from JSON)
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      price: (json['price'] as num).toDouble(),
      billingCycle: json['billing_cycle'] as String,
      nextBillDate: DateTime.parse(json['next_bill_date'] as String),
      category: json['category'] as String,
      displayColor: json['display_color'] != null
          ? Color(json['display_color'] as int)
          : null,
    );
  }

  // Method to convert a Subscription object to a Map (e.g., for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'price': price,
      'billing_cycle': billingCycle,
      'next_bill_date': nextBillDate.toIso8601String(),
      'category': category,
      'display_color': displayColor?.value,
    };
  }
}