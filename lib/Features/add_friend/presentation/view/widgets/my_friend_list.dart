import 'package:flutter/material.dart';

class MyFriendList extends StatelessWidget {
  const MyFriendList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 20,
      color: Colors.green,
      backgroundColor: Colors.white,
      strokeWidth: 2,
      onRefresh: () async {},
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: 50,
            color: Colors.white,
            child: Row(children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
              ),
              const SizedBox(width: 10),
              const Text(
                "User Name",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ))
            ]),
          );
        },
      ),
    );
  }
}
