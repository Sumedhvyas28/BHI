import 'package:bhi/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePreferencesPage extends StatelessWidget {
  const ThemePreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

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
              trailing: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: themeNotifier.themeMode,
                onChanged: (value) {
                  themeNotifier.setTheme(value!);
                },
              ),
            ),
            ListTile(
              title: const Text("Dark Theme"),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: themeNotifier.themeMode,
                onChanged: (value) {
                  themeNotifier.setTheme(value!);
                },
              ),
            ),
            ListTile(
              title: const Text("System Default"),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: themeNotifier.themeMode,
                onChanged: (value) {
                  themeNotifier.setTheme(value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
