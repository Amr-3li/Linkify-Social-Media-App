import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  get widget => null;

  Future<void> pickImage(ValueChanged<File?> image) async {
    File imageFile;
    XFile? ximage = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(ximage!.path);
    image(imageFile);
  }
}
