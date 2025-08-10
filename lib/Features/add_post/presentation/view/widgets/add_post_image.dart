import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';
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
              imageFile = await PickImage().pickImage();
              widget.onImagePicked(imageFile);
              setState(() {});
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Image.asset(
                MyIcons.iconsAddImage,
                color: MyColors.toMessageBorder,
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
