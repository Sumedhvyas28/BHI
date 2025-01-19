import 'package:bhi/constant/pallete.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroSmallPage3 extends StatefulWidget {
  const IntroSmallPage3({super.key});

  @override
  State<IntroSmallPage3> createState() => _IntroSmallPage3State();
}

class _IntroSmallPage3State extends State<IntroSmallPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
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
              'assets/onboarding/1.json',
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
                  'Optimized Delivery Operations',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Pallete.mainFontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Organize and simplify your deliveries.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Ensure accurate and timely shipments.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Grow with reliable logistics!',
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
