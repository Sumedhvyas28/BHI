import 'package:bhi/constant/pallete.dart';
import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account Settings",
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
            // Personal Information Section
            const Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildInputField(
              label: "Username",
              placeholder: "Enter your username",
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 15),
            _buildInputField(
              label: "Email Address",
              placeholder: "Enter your email address",
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 15),
            _buildInputField(
              label: "Phone Number",
              placeholder: "Enter your phone number",
              icon: Icons.phone_outlined,
            ),
            const SizedBox(height: 15),
            _buildInputField(
              label: "Your Address",
              placeholder: "Enter your address",
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 15),
            _buildInputField(
              label: "Shop Address",
              placeholder: "Enter your shop address",
              icon: Icons.storefront_outlined,
            ),
            const SizedBox(height: 25),
            const Divider(),

            // Section for Enable Notifications
            const SizedBox(height: 15),
            const Text(
              "Notifications",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Enable Notifications",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: true,
                  activeColor: Pallete.mainFontColor,
                  onChanged: (bool value) {
                    // Add your notification toggle logic here
                  },
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 25),

            // Save Changes Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add save changes functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.mainFontColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable input field widget
  Widget _buildInputField({
    required String label,
    required String placeholder,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
