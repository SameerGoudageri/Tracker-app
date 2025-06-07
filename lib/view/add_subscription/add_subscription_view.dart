import 'package:flutter/material.dart';
import 'package:trail2/models/subscription.dart'; // Import your Subscription model
import 'package:trail2/common/color_extension.dart'; // Import TColor for default color

class AddSubScriptionView extends StatefulWidget {
  const AddSubScriptionView({super.key});

  @override
  State<AddSubScriptionView> createState() => _AddSubScriptionViewState();
}

class _AddSubScriptionViewState extends State<AddSubScriptionView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // 1. List of available icon paths from your assets/img folder
  // IMPORTANT: Replace these with the ACTUAL paths to your icon files!
  // Ensure these assets are declared in your pubspec.yaml
  final List<String> availableIcons = [
     // Keep a default one
    "assets/img/spotify_logo.png", // Example: if you have spotify_icon.png
    "assets/img/youtube_logo.png", // Example: if you have youtube_icon.png
    "assets/img/netflix_logo.png", // Example: if you have netflix_icon.png
     // Example: if you have google_drive_icon.png
    // Add more icon paths as you have them in assets/img/
  ];

  String? selectedIconPath; // To store the currently selected icon path

  @override
  void initState() {
    super.initState();
    // Set a default selected icon when the view loads
    selectedIconPath = availableIcons.isNotEmpty ? availableIcons[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Add Subscription",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView for scrollability
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align elements to start
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Price (₹)",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Icon Selection UI
            Text(
              "Select Icon:",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60, // Height for the icon selection row
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableIcons.length,
                itemBuilder: (context, index) {
                  final iconPath = availableIcons[index];
                  final isSelected = iconPath == selectedIconPath;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIconPath = iconPath; // 3. Update selected icon
                      });
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? TColor.primary.withOpacity(0.5) : Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                        border: isSelected ? Border.all(color: TColor.primary, width: 2) : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          iconPath,
                          width: 40,
                          height: 40,
                           // Assuming icons are line-art/single-color
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                final String name = nameController.text.trim();
                final double price = double.tryParse(priceController.text) ?? 0.0;

                if (name.isEmpty || price <= 0 || selectedIconPath == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid name, price, and select an icon.')),
                  );
                  return;
                }

                final newSubscription = Subscription(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  price: price,
                  icon: selectedIconPath!, // 4. Use the selected icon path
                  billingCycle: "Monthly", // You can make this dynamic too
                  nextBillDate: DateTime.now().add(const Duration(days: 30)),
                  category: "Other", // You can make this dynamic too
                  displayColor: TColor.secondary, // You can make this dynamic too
                );

                Navigator.pop(context, newSubscription);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Add Subscription",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }
}