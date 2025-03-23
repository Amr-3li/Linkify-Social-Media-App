import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

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
          return const Column(
            children: [
              ListTile(
                onTap: null,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png",
                  ),
                ),
                title: Text("User Name"),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
