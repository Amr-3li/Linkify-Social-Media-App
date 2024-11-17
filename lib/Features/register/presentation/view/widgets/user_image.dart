import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';

class UserImage extends StatefulWidget {
  const UserImage({super.key, required this.image});
  final ValueChanged<File?> image;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? imageFile;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            isLoading = true;
            setState(() {});
            try {
              await pickImage();
            } catch (e) {
              isLoading = false;
              setState(() {});
            }
            isLoading = false;
            setState(() {});
          },
          child: imageFile != null
              ? Skeletonizer(
                  enabled: isLoading,
                  child: CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color.fromARGB(255, 130, 130, 130),
                      child: CircleAvatar(
                          radius: 58,
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(imageFile!))),
                )
              : Stack(children: [
                  const CircleAvatar(
                      radius: 60,
                      backgroundColor: Color.fromARGB(150, 188, 188, 188),
                      child: Icon(
                        Icons.person,
                        size: 80,
                      )),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color.fromARGB(255, 15, 0, 101),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  )
                ]),
        );
      },
    );
  }

  Future<void> pickImage() async {
    XFile? ximage = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(ximage!.path);
    widget.image(imageFile!);
  }
}
