import 'package:flutter/material.dart';

class CustomFreindsButton extends StatelessWidget {
  const CustomFreindsButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.color});
  final String title;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(100, 10),
          padding: const EdgeInsets.all(1),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600)));
  }
}
