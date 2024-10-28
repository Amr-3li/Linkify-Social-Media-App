import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                centerTitle: true,
                title: const Text("User name"),
                actions: [
                  ClipOval(
                      child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.green,
                    
                  )),
                  const SizedBox(width: 10),
                ],
              )
            ],
        body: const Center(child: Text("Profile")));
  }
}
