import 'package:flutter/material.dart';
import 'package:linkify/core/constants/images.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      onTap: null,
      tileColor: Color.fromARGB(121, 100, 255, 219),
      leading: Stack(children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(MyImages.imagesUserImage),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.green,
            child: Icon(Icons.favorite, color: Colors.white, size: 12),
          ),
        )
      ]),
      title: Text("Notification title"),
      subtitle: Text(
        "Notification subtitleas fasdf asfg asdf asdg asg asdg asg as gas",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
