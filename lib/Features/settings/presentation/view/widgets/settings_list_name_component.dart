import 'package:flutter/material.dart';

class ListNameComponent extends StatelessWidget {
  const ListNameComponent({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      minTileHeight: 30,
      titleAlignment: ListTileTitleAlignment.center,
      title: Text("GENERAL  ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      tileColor: Color.fromARGB(255, 195, 204, 205),
    );
  }
}
