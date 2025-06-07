import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign titleAlign;
  final bool obscureText;
  const RoundTextField(
      {super.key,
        required this.title,
        this.titleAlign = TextAlign.left,
        this.controller,
        this.keyboardType,
        this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: titleAlign,
                style: TextStyle(color: TColor.secondaryG50, fontSize: 12), // Title as a neon prompt
              ),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 48,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: TColor.gray60.withOpacity(0.1), // Slightly more opaque background
              border: Border.all(color: TColor.secondaryG.withOpacity(0.7)), // Prominent neon border
              borderRadius: BorderRadius.circular(8)), // More angular corners
          child: TextField(
            controller: controller,
            style: TextStyle(color: TColor.white), // Input text color
            decoration: InputDecoration(
              focusedBorder: InputBorder.none, // Remove default Flutter borders as we're using Container's border
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 14), // Adjust padding
            ),
            keyboardType: keyboardType,
            obscureText: obscureText,
            cursorColor: TColor.secondaryG, // Neon cursor color
          ),
        )
      ],
    );
  }
}