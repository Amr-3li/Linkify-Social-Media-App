import 'package:flutter/material.dart';
import 'package:true_gym/core/utils/consts.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 254, 254),
          boxShadow: [
            BoxShadow(
                color: MyColors.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10))
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: const Center(
          child: Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
