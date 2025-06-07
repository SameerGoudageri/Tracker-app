import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class BudgetsRow extends StatelessWidget {
  final Map bObj;
  final VoidCallback onPressed;

  const BudgetsRow({super.key, required this.bObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Safely get numerical values, defaulting to 0.0 if parsing fails or key is missing
    double leftAmount = double.tryParse(bObj["left_amount"]?.toString() ?? "0.0") ?? 0.0;
    double totalBudget = double.tryParse(bObj["total_budget"]?.toString() ?? "0.0") ?? 0.0;
    double spendAmount = double.tryParse(bObj["spend_amount"]?.toString() ?? "0.0") ?? 0.0;

    // Calculate progress, handling division by zero to prevent Infinity/NaN
    double proVal = (totalBudget > 0) ? (leftAmount / totalBudget) : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: TColor.border.withOpacity(0.05),
            ),
            color: TColor.gray60.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      // Provide a default icon path if 'icon' key is missing or null
                      bObj["icon"]?.toString() ?? "assets/img/default_icon.png",
                      width: 30,
                      height: 30,
                      color: TColor.gray40,
                      // Add an errorBuilder for robustness in case image asset is bad
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 30, color: Colors.grey);
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // Provide a default name if 'name' key is missing or null
                          bObj["name"]?.toString() ?? "Unknown Budget",
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          // Use the parsed amount, formatted to 2 decimal places
                          "Left ₹${leftAmount.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: TColor.gray30,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // Use the parsed amount, formatted to 2 decimal places
                          "₹${spendAmount.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // Use the parsed amount, formatted to 2 decimal places
                          "of ₹${totalBudget.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: TColor.gray30,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                ],
              ),
              const SizedBox(height: 8,),
              LinearProgressIndicator(
                backgroundColor: TColor.gray60,
                // Ensure 'color' is treated as a Color and provide a fallback
                valueColor: AlwaysStoppedAnimation<Color>(bObj["color"] as Color? ?? TColor.primary),
                minHeight: 3,
                value: proVal,
              )
            ],
          ),
        ),
      ),
    );
  }
}