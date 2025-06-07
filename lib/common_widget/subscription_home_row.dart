import 'package:flutter/material.dart';
import 'package:trail2/common/color_extension.dart';

class SubScriptionHomeRow extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;
  final VoidCallback? onDeletePressed;

  const SubScriptionHomeRow({
    super.key,
    required this.sObj,
    required this.onPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color displayColor = sObj["displayColor"] is Color
        ? sObj["displayColor"] as Color
        : TColor.gray60;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: displayColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Hero(
              tag: 'subscription_icon_${sObj["id"]}',
              child: Image.asset(
                sObj["icon"] ?? "assets/img/default_icon.png",
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 40, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sObj["name"] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "₹${sObj["price"] ?? "0.00"}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (onDeletePressed != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDeletePressed,
              ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}