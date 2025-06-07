import 'package:flutter/material.dart';
import 'package:trail2/common/color_extension.dart'; // Assuming you have this

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(TColor.primary), // Customize color if needed
      ),
    );
  }
}