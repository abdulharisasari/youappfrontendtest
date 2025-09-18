import 'package:flutter/material.dart';

class CustomBackButtonRow extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;

  const CustomBackButtonRow({
    super.key,
    required this.onTap,
    this.text = "Back",
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.chevron_left, color: color),
          const SizedBox(width: 4), 
          Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
