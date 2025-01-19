import 'package:bhi/constant/pallete.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroSmallPage2 extends StatefulWidget {
  const IntroSmallPage2({super.key});

  @override
  State<IntroSmallPage2> createState() => _IntroSmallPage2State();
}

class _IntroSmallPage2State extends State<IntroSmallPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Logo and title
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png',
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          // Main image
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Lottie.asset(
              'assets/onboarding/3.json',
              height: 300,
            ),
          ),
          // Text content
          Positioned(
            top: 420,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Inventory Management',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Pallete.mainFontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Track and organize your stock efficiently.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Improve sales with better inventory flow.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Enhance customer satisfaction!',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
