import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';
import 'package:true_gym/Features/register/data/web_servecies/storage_ser.dart';
import 'package:true_gym/core/errors/failures.dart';
import 'package:true_gym/core/utils/project_endpoints.dart';

class ImageRepoImpl implements ImageRepo {
  final StorageService storageService;

  ImageRepoImpl(this.storageService);

  @override
  Future<Either<Failure, String>> uploadImageToFirebase(File image) async {
    try {
      String url = await storageService.uploadImageToFirebase(
          image, ProjectEndpoints.imageClientBath);
      return Right(url);
    } catch (e) {
      return Left(
        ServerFailure("failed to upload image"),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadrecordToFirebase(File record) async {
    try {
      String url = await storageService.uploadImageToFirebase(
          record, ProjectEndpoints.recordClientBath);
      return Right(url);
    } catch (e) {
      return Left(
        ServerFailure("failed to upload image"),
      );
    }
  }
}
