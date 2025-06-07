import 'package:flutter/material.dart'; // For Color, if you store it directly

enum TransactionType { income, expense, subscription }

class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String category; // e.g., "Food", "Transport", "Salary"
  final String? accountId; // Which account it came from/went to

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    this.accountId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      type: TransactionType.values.firstWhere(
              (e) => e.toString() == 'TransactionType.${json['type']}',
          orElse: () => TransactionType.expense), // Default to expense
      category: json['category'] as String,
      accountId: json['account_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.toString().split('.').last,
      'category': category,
      'account_id': accountId,
    };
  }
}