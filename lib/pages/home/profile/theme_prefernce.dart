import 'package:bhi/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePreferencesPage extends StatelessWidget {
  const ThemePreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Theme Preferences",
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose App Theme",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text("Light Theme"),
            ),
            ListTile(
              title: const Text("Dark Theme"),
            ),
            ListTile(
              title: const Text("System Default"),
            ),
          ],
        ),
      ),
    );
  }
}
