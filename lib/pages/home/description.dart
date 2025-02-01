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
          "The Alchemist",
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
              'The Alchemist',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Book Cover Image
            Image.asset(
              'assets/home/alech.jpg', // Replace with the correct path to your image
              width: screenWidth * 0.7, // Adjust the size to fit your design
              height: screenHeight * 0.3, // Adjust the height
              fit: BoxFit.cover, // Ensure the image fits properly
            ),
            const SizedBox(height: 20),

            // Initial Description Text
            const Text(
              'Paulo Coelhos enchanting novel has inspired a devoted following around the world. This story, dazzling in its powerful simplicity and inspiring wisdom, is about an Andalusian shepherd boy named Santiago who travels from his homeland in Spain to the Egyptian desert in search of a treasure buried in the Pyramids. Along the way he meets a Gypsy woman, a man who calls himself',
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
                'Through the journey, Santiago learns the language of omens and follows his "Personal Legend." '
                'Guided by the wisdom of the Alchemist, he realizes that true treasure lies not just in material wealth, '
                'but in self-discovery and the pursuit of one’s dreams. The novel blends mysticism, philosophy, and adventure, '
                'encouraging readers to listen to their hearts and embrace the journey of life.',
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
              'Born in Brazil, Paulo Coelho started his career as a lyricist and theatre director and later left it to become an author. Paulo has written and published over 30 books and is also an avid blogger. He is active on numerous other social media platforms. Paulo Coelho was named the Messenger of Peace of the United Nations in 2007 and has bagged numerous prestigious awards like the Crystal Award by the World Economic Forum, The Honorable Award of the President of the Republic by the President of Bulgaria and so on.',
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
              'ASIN : 8172234988\n'
              'Publisher:Harper; Later Printing edition (17 October 2005)\n'
              'Language : English\n'
              'Paperback  : 172 pages\n'
              'ISBN-10 : 9788172234980\n'
              'ISBN-13  :   978-8172234980\n'
              'Reading age :Customer suggested age: 14 years and up\n'
              'Item Weight : 125 g\n'
              'Dimensions  : 12.9 x 1.5 x 19.8 cm\n'
              'Country of Origin :United Kingdom\n'
              'Net Quantity:1.00 count\n'
              'Generic Name  : The Alchemist 12.9 x 1.5 x 19.8 cm\n'
              'Best Sellers Rank: #53 in Books (See Top 100 in Books)\n'
              '#8 in Contemporary Fiction (Books)\n'
              'Customer Reviews: 4.6 4.6 out of 5 stars    45,602 ratings',
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
