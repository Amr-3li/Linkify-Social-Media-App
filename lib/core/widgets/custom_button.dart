import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });
  final String title;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: color,
          boxShadow: const [
            BoxShadow(
                color: MyColors.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10))
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
