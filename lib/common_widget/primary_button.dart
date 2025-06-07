import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  const PrimaryButton({super.key, required this.title, this.fontSize = 14, this.fontWeight = FontWeight.w600, required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/img/primary_btn.png"), // Consider replacing this with a more dynamic, less organic-looking asset for a stronger cyberpunk feel.
            ),
            borderRadius: BorderRadius.circular(8), // More angular, less rounded corners
            boxShadow: [
              BoxShadow(
                  color: TColor.secondaryG.withOpacity(0.5), // Stronger, vibrant neon glow
                  blurRadius: 15, // Increased blur for more glow
                  offset: const Offset(0, 6)) // Slight offset for depth
            ]),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: TColor.white, // Text color remains white for contrast
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: 0.8 // Slightly increased letter spacing for a digital look
          ),
        ),
      ),
    );
  }
}