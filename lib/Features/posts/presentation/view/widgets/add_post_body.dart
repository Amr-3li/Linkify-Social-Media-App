import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AddPostBody extends StatelessWidget {
  const AddPostBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          width: double.infinity,
          height: 200,
          child: TextFormField(
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: "write post",
              disabledBorder: InputBorder.none,
            ),
            maxLines: 30,
          ),
        )
      ],
    );
  }
}
