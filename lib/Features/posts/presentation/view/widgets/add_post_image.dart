import 'package:flutter/material.dart';
import 'package:true_gym/core/constants/icons.dart';

class AddPostImage extends StatelessWidget {
  const AddPostImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromARGB(100, 199, 199, 199),
            image: DecorationImage(
              image: AssetImage(
                MyIcons.iconsAddImage,
              ),
              opacity: 0.5,
            )),
      ),
    );
  }
}
