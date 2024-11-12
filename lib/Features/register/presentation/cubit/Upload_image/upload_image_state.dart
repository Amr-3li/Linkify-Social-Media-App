// ignore_for_file: must_be_immutable

part of 'upload_image_cubit.dart';

sealed class UploadImageState {}

final class UploadImageInitial extends UploadImageState {}

//==============image==================
final class UploadImageLoading extends UploadImageState {}

final class UploadImageSuccess extends UploadImageState {
  File imageFile;
  UploadImageSuccess(this.imageFile);
}

final class UploadImageError extends UploadImageState {
  String message;
  UploadImageError(this.message);
}

//==============Selecte image==================
final class SelectImageloading extends UploadImageState {}

final class SelectImageSuccess extends UploadImageState {
  File imageFile;
  SelectImageSuccess(this.imageFile);
}

final class SelectImageError extends UploadImageState {
  String message;
  SelectImageError(this.message);
}
