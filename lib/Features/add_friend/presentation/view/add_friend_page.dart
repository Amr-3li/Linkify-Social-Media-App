import 'package:flutter/material.dart';
import 'package:linkify/Features/add_friend/presentation/view/widgets/my_friend_list.dart';
import 'package:linkify/core/constants/colors.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Column(children: [
          Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: MyColors.appBarColor,
              margin: const EdgeInsets.only(top: 50),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    tapNavigateItem(0, "My Friends"),
                    tapNavigateItem(1, "Friend requests"),
                    tapNavigateItem(2, "My requests")
                  ])),
          Expanded(
              child: IndexedStack(
            index: currentIndex,
            children: const [
              MyFriendList(),
              Center(child: Text("Friend requests")),
              Center(child: Text("My requests"))
            ],
          ))
        ]));
  }

  GestureDetector tapNavigateItem(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          currentIndex == index
              ? Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 70,
                  height: 2.5,
                  color: Colors.white)
              : const SizedBox(),
        ],
      ),
    );
  }
}
