import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:true_gym/core/errors/failures.dart';

abstract class ImageRepo {
  Future<Either<Failure, String>> uploadImageToFirebase(File image);
  Future<Either<Failure, String>> uploadrecordToFirebase(File record);
}
