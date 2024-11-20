import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';
import 'package:true_gym/Features/register/data/web_servecies/storage_ser.dart';
import 'package:true_gym/core/backend_endpoints.dart';
import 'package:true_gym/core/errors/failures.dart';

class ImageRepoImpl implements ImageRepo {
  final StorageService storageService;

  ImageRepoImpl(this.storageService);

  @override
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
