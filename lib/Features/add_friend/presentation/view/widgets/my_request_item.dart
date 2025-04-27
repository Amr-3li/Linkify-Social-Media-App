import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class MyRequestItem extends StatelessWidget {
  const MyRequestItem({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(
              user.image == "" ? Constants.defaultUserImage : user.image!,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              user.name,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 10),
              padding: const EdgeInsets.all(1),
              backgroundColor: const Color.fromARGB(149, 151, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("UnSend",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
