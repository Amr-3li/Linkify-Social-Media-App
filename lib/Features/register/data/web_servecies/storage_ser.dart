import 'dart:io';

abstract class StorageService {
  Future<String> uploadImageToFirebase(File imageFile, String path);
}
