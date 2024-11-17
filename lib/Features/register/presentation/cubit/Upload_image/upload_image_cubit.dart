import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit(this.imageRepo) : super(UploadImageInitial());
  final ImageRepo imageRepo;

  Future<String> uploadImageToFirebase(File image) async {
    String url = await ImageRepo().uploadImageToFirebase(image);
    return url;
  }
}
