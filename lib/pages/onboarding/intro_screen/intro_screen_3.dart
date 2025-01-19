import 'package:bhi/constant/pallete.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 93,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png',
                  height: 79,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Lottie.asset(
              'assets/onboarding/1.json',
              height: 420,
            ),
          ),
          const Positioned(
            top: 550,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Optimized Delivery Operations',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Pallete.mainFontColor,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Organize and simplify your deliveries.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Ensure accurate and timely shipments.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Grow with reliable logistics!',
                  style: TextStyle(fontSize: 16),
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
