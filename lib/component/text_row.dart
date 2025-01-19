import 'package:flutter/material.dart';

class IconTextRow extends StatelessWidget {
  final String? imagePath; // Path for custom image
  final IconData? icon; // IconData for material icons
  final String text; // Text to display
  final VoidCallback onPressed; // Callback function

  const IconTextRow({
    Key? key,
    this.imagePath, // Either provide imagePath
    this.icon, // Or provide icon
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            if (imagePath != null) // Show custom image if imagePath is provided
              Image.asset(
                imagePath!,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              )
            else if (icon != null) // Fallback to material icon if no imagePath
              Icon(
                icon,
                size: 40,
                color: Colors.blueGrey,
              ),
            SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
