import 'package:flutter/material.dart';

class Dialogs {
  static Future<dynamic> deletePostDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete this post?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
    );
  }

  static Future<dynamic> editPostDialog(
      BuildContext context, String description) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextFormField(
                  style: const TextStyle(fontSize: 12),
                  maxLines: 5,
                  minLines: 1,
                  controller: TextEditingController(text: description),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  )),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ));
  }
}
