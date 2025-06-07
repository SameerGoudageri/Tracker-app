import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class SegmentButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isActive;

  const SegmentButton({
    super.key,
    required this.title,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10), // Added padding
        decoration: BoxDecoration(
          border: isActive
              ? Border.all(
            color: TColor.border.withOpacity(0.15),
          )
              : null,
          color: isActive
              ? TColor.gray60.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: FittedBox( // Prevents overflow
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? TColor.white : TColor.gray30,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
