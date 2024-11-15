import 'package:flutter/material.dart';

// Custom rectangular ElevatedButton widget without border radius
class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final double height;

  Button({
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.height = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:Color(0xFF2E3B62), // Custom background color
        foregroundColor: textColor, // Custom text color
        padding: EdgeInsets.symmetric(vertical: height, horizontal: 110), // Adequate padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Ensures no border radius
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown, // Ensures text scales within its constraints
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16, // Font size
            overflow: TextOverflow.ellipsis, // Handles overflow gracefully
          ),
          maxLines: 1, // Ensures single-line text
        ),
      ),
    );
  }
}
