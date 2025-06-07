// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:trail2/common/color_extension.dart';
import 'package:trail2/view/main_tab/main_tab_view.dart';
import 'package:trail2/view_models/home_view_model.dart';
 // Adjust this path if your MainTabView is in a different directory// Import your ViewModel

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(), // Provide your HomeViewModel
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trackizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        colorScheme: ColorScheme.fromSeed(
          seedColor: TColor.primary,
          background: TColor.gray80,
          primary: TColor.primary,
          primaryContainer: TColor.gray60,
          secondary: TColor.secondary,
        ),
        useMaterial3: false,
      ),
      home: const MainTabView(),
    );
  }
}