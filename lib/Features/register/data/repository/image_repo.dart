// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:true_gym/Features/register/data/web_servecies/fire_storage.dart';
import 'package:true_gym/core/backend_endpoints.dart';

class ImageRepo {
  FireStorage fireStorage;
  ImageRepo(this.fireStorage);
  Future<String> uploadImageToFirebase(File image) async {
    String url = await fireStorage.uploadImageToFirebase(
        image, BackendEndpoints.ImageBath);
    return url;
  }
}
