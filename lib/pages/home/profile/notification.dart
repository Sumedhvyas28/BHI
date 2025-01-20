import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isEmailNotificationsEnabled = true;
  bool isPushNotificationsEnabled = true;
  bool isSMSNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            "Notification Settings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildNotificationToggle(
            title: "Email Notifications",
            subtitle: "Get updates via email",
            value: isEmailNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                isEmailNotificationsEnabled = value;
              });
            },
          ),
          _buildNotificationToggle(
            title: "Push Notifications",
            subtitle: "Receive push notifications on your device",
            value: isPushNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                isPushNotificationsEnabled = value;
              });
            },
          ),
          _buildNotificationToggle(
            title: "SMS Notifications",
            subtitle: "Get updates via text messages",
            value: isSMSNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                isSMSNotificationsEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      children: [
        SwitchListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          value: value,
          activeColor: Colors.blue,
          onChanged: onChanged,
        ),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
