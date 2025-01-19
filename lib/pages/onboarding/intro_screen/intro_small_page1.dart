import 'package:bhi/constant/pallete.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroSmallPage1 extends StatefulWidget {
  const IntroSmallPage1({super.key});

  @override
  State<IntroSmallPage1> createState() => _IntroSmallPage1State();
}

class _IntroSmallPage1State extends State<IntroSmallPage1> {
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
              'assets/onboarding/2.json',
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
                  'Content Management',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Pallete.mainFontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Create and manage all your publications.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Streamline tasks and boost productivity.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Deliver engaging content!',
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
