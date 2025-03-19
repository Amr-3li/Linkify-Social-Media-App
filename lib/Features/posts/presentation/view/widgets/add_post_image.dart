import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linkify/core/constants/icons.dart';
import 'package:linkify/core/helper/pick_image.dart';

class AddPostImage extends StatefulWidget {
  const AddPostImage({
    super.key,
    required this.onImagePicked,
  });
  final ValueChanged<File?> onImagePicked;
  @override
  State<AddPostImage> createState() => _AddPostImageState();
}

class _AddPostImageState extends State<AddPostImage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return imageFile == null
        ? InkWell(
            onTap: () async {
              await PickImage().pickImage((value) {
                setState(() {
                  imageFile = value;
                  widget.onImagePicked(value);
                });
              });
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromARGB(100, 199, 199, 199),
                image: DecorationImage(
                  image: AssetImage(MyIcons.iconsAddImage),
                ),
              ),
            ),
          )
        : Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 200,
                width: double.infinity,
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      imageFile = null;
                      widget.onImagePicked(null);
                    });
                  },
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Color.fromARGB(163, 255, 255, 255),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
