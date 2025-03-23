import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Comments",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
          ),
          backgroundColor: MyColors.appBarColor),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {},
                leading: SizedBox(
                  width: 40,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(Constants.defaultUserImage),
                    ),
                  ),
                ),
                title: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "time",
                      style: TextStyle(color: MyColors.time),
                    ),
                  ],
                ),
                subtitle: const Text(
                  "Comment asggsagjn sdjasdhg jsadgn sdjg sdjgn sjbg sajdgb sadjgsdgsalg lsabdg asdgjbnsad gjsdabng asdjgasdjgbasdgjbasjghlasbdjgbasdng s gs gjsbdg js bgjsb jgsljbg s",
                  style: TextStyle(color: Colors.black),
                  maxLines: 15,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
