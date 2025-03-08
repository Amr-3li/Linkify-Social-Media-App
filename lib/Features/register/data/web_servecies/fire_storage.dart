import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:linkify/Features/register/data/web_servecies/storage_ser.dart';
import 'package:path/path.dart' as p;

class FireStorage implements StorageService {
  final firebaseStorage = FirebaseStorage.instance.ref();
  @override
  Future<String> uploadImageToFirebase(File imageFile, String path) async {
    String fileName = p.basename(imageFile.path);
    String extension = p.extension(imageFile.path);
    Reference ref = firebaseStorage.child('$path/$fileName.$extension');
    await ref.putFile(imageFile);
    return ref.getDownloadURL();
  }

  @override
  Future<String> uploadaudioToFirebase(File audioFile, String path) {
    throw UnimplementedError();
  }
}
