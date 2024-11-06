import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const CircleAvatar(
          radius: 60,
          backgroundColor: Color.fromARGB(150, 188, 188, 188),
          child: Icon(
            Icons.person,
            size: 80,
          )),
      Positioned(
          child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.blue,
        child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
            )),
      ))
    ]);
  }
}
