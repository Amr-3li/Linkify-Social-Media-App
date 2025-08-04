import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  get widget => null;

  Future<File> pickImage() async {
    File imageFile;
    XFile? ximage = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(ximage!.path);
    return imageFile;
  }
}
