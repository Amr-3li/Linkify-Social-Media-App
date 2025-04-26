import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyFriendItem extends StatelessWidget {
  const MyFriendItem({super.key});

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
          const CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "User Name",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'unfriend') {
                  // هنا تحط لوجيك الـ unfriend
                  debugPrint('Unfriend Clicked');
                }
              },
              itemBuilder: (context) => [
                    const PopupMenuItem<String>(
                        value: 'unfriend', child: Text("Unfriend")),
                  ],
              icon: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
