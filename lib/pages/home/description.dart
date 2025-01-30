import 'package:flutter/material.dart';
import 'package:bhi/constant/pallete.dart'; // assuming the same color palette

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  bool _isExpanded =
      false; // Flag to toggle between expanded and collapsed text

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yama",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            // Title
            const Text(
              'Yama Kindle Edition',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Book Cover Image
            Image.asset(
              'assets/home/yama.jpg', // Replace with the correct path to your image
              width: screenWidth * 0.7, // Adjust the size to fit your design
              height: screenHeight * 0.3, // Adjust the height
              fit: BoxFit.cover, // Ensure the image fits properly
            ),
            const SizedBox(height: 20),

            // Initial Description Text
            const Text(
              'Yama follows the gripping story of Dhruvi Rajput, a psychotherapist who has lost the two most important people in her life. Her world takes an unexpected turn when she receives a call from a mysterious man identifying himself as Yama, the God of Death.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // Conditionally Expanded Description Text
            AnimatedCrossFade(
              firstChild:
                  const SizedBox.shrink(), // Empty widget for collapsed state
              secondChild: const Text(
                'Basheer Ali, a Senior Inspector at the CBI, investigates the vigilante killer "Yama," who punishes the corrupt and guilty by exposing them on social media before serving fatal justice. As the story unfolds, Dhruvi and Basheer must confront their own moral dilemmas while chasing the shadowy figure of Yama. The story leads to an unexpected final choice that will have readers questioning their own sense of justice.',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),

            const SizedBox(height: 20),

            // Button to toggle the expanded description
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded; // Toggle the boolean value
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.mainDashColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
              ),
              child: Text(
                _isExpanded ? 'Read Less' : 'Read More',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // About the Author section
            const Text(
              'About the Author',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kevin Missal is a best-selling author who wrote his first book at the age of 14. His works have garnered a large fanbase, especially his Kalki series, which has been a runaway success. At just 24 years old, Kevin has already established himself as a full-time writer. He is passionate about fantasy fiction and mythology. Kevin lives in Gurugram and can be contacted via email at kevin.s.missal@gmail.com.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),

            // Product details
            const Text(
              'Product Details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'ASIN: B08KRMF4GY\nPublisher: S&S India (15 October 2020)\nLanguage: English\nFile size: 829 KB\nText-to-Speech: Enabled\nScreen Reader: Supported\nEnhanced typesetting: Enabled\nX-Ray: Not Enabled\nWord Wise: Enabled\nBest Sellers Rank: #45,517 in Kindle Store\n#286 in Urban Fantasy (Books)\n#508 in Mythology & Folk Tales\n#1,428 in Myths, Legends & Sagas',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
