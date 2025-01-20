import 'package:bhi/firebase_options.dart';
import 'package:bhi/pages/auth/login_screen.dart';
import 'package:bhi/pages/splash_screen.dart';
import 'package:bhi/starter_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Light Theme Settings
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light, // Explicitly set brightness to light
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // Default white background
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme:
              IconThemeData(color: Colors.black), // Ensure black icons on white
          titleTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Make bottom nav bar background white
          selectedItemColor: Colors.deepPurple, // Customize selected item color
          unselectedItemColor:
              Colors.black54, // Customize unselected item color
        ),
      ),
      darkTheme: ThemeData(
        // Dark Theme Settings
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark, // Explicitly set brightness to dark
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black, // Dark background
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white), // White icons on black
          titleTextStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black, // Dark background for bottom nav bar
          selectedItemColor: Colors.deepPurple, // Customize selected item color
          unselectedItemColor:
              Colors.white70, // Customize unselected item color
        ),
      ),
      themeMode: themeNotifier.themeMode, // Dynamically switches theme
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
