import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit() : super(UploadImageInitial());

  File? imageFile;
  Future<void> getImage() async {
    emit(SelectImageloading());
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        emit(SelectImageSuccess(imageFile!));
      } else {
        emit(SelectImageError('no image selected'));
      }
    });
  }

  Future<String> uploadImageToFirebase() async {}
}
