// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:true_gym/Features/register/data/web_servecies/storage_ser.dart';
import 'package:true_gym/core/backend_endpoints.dart';
import 'package:true_gym/core/errors/failures.dart';

class ImageRepo {
  ImageRepo(this.storageService);
  StorageService storageService;

  Future<Either<Failure, String>> uploadImageToFirebase(File image) async {
    try {
      String url = await storageService.uploadImageToFirebase(
          image, BackendEndpoints.ImageBath);
      return Right(url);
    } catch (e) {
      return Left(
        ServerFailure("failed to upload image"),
      );
    }
  }
}
