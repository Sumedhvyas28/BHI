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
          "Jujutsu Kaisen - Description",
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
              'Jujutsu Kaisen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Initial Description Text
            const Text(
              'Jujutsu Kaisen follows the story of Yuji Itadori, a high school student who joins the Tokyo Metropolitan Jujutsu Technical College after ingesting a cursed object and gaining immense supernatural abilities. The story revolves around Yuji’s fight against curses and his growing relationships with his classmates, including Megumi Fushiguro and Nobara Kugisaki.',
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
                'It combines thrilling action, supernatural themes, and deep character development. The anime adaptation further enhances this with stunning animation and captivating fight sequences. As the story unfolds, Yuji’s bond with his friends and his quest to find meaning in his powers deepen.  ',
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
          ],
        ),
      ),
    );
  }
}
