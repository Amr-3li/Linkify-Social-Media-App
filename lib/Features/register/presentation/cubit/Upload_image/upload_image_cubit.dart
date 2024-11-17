import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit(this.imageRepo) : super(UploadImageInitial());
  final ImageRepo imageRepo;
  File? imageFile;
  Future<void> getImage(File? imageFile) async {
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

  Future<String> uploadImageToFirebase(File image) async {
    String url = await ImageRepo().uploadImageToFirebase(image);
    return url;
  }
}
