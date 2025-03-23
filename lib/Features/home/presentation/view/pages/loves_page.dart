import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';

class LovesPage extends StatelessWidget {
  const LovesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lovers",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        backgroundColor: MyColors.appBarColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                onTap: null,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    Constants.defaultUserImage,
                  ),
                ),
                title: const Text("User Name"),
              ),
              const Divider(
                  color: MyColors.fromMessageBorder,
                  indent: 15,
                  endIndent: 15,
                  height: 5,
                  thickness: 0.6),
            ],
          );
        },
      ),
    );
  }
}
