import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:linkify/Features/register/data/web_servecies/storage_ser.dart';
import 'package:path/path.dart' as p;

class SupabaseStorage implements StorageService {
  final SupabaseClient _client;
  static const String _bucketName = 'true_gym_assets';

  SupabaseStorage({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  @override
  Future<String> uploadImageToFirebase(File file, String path) async {
    return _uploadFile(file, path, isImage: true);
  }

  @override
  Future<String> uploadaudioToFirebase(File file, String path) async {
    return _uploadFile(file, path, isAudio: true);
  }

  Future<String> _uploadFile(
    File file,
    String path, {
    bool isImage = false,
    bool isAudio = false,
  }) async {
    try {
      // Validate file first
      await _validateFile(file, isImage: isImage, isAudio: isAudio);

      // Generate unique filename
      final now = DateTime.now().microsecondsSinceEpoch;
      final fileName = '${p.basenameWithoutExtension(file.path)}$now';
      final filePath = '$path/$fileName';

      // Upload file
      await _client.storage.from(_bucketName).upload(filePath, file,
          fileOptions: _getFileOptions(isImage: isImage));

      // Get public URL
      return _client.storage.from(_bucketName).getPublicUrl(filePath);
    } on StorageException catch (e) {
      throw StorageServiceException(_handleStorageError(e));
    } catch (e) {
      throw StorageServiceException('Failed to upload file. Please try again.');
    }
  }

  FileOptions _getFileOptions({bool isImage = false}) {
    return FileOptions(
      cacheControl: '3600',
      upsert: false,
      contentType: isImage ? 'image/jpeg' : 'audio/mpeg',
    );
  }

  Future<void> _validateFile(File file,
      {bool isImage = false, bool isAudio = false}) async {
    final fileSize = await file.length();

    if (isImage) {
      if (fileSize > 5 * 1024 * 1024) {
        // 5MB
        throw StorageServiceException('Image size must be less than 5MB');
      }
    } else if (isAudio) {
      if (fileSize > 20 * 1024 * 1024) {
        // 20MB
        throw StorageServiceException('Audio file must be less than 20MB');
      }
    }

    if (!await file.exists()) {
      throw StorageServiceException('File does not exist');
    }
  }

  String _handleStorageError(StorageException e) {
    switch (e.statusCode) {
      case "400":
        if (e.message.contains('already exists')) {
          return 'File with this name already exists';
        }
        return 'Invalid file format or path';
      case "401":
        return 'Authentication required';
      case "403":
        return 'You don\'t have permission for this operation';
      case '404':
        return 'Storage bucket not found';
      case '413':
        return 'File size exceeds limit';
      case '422':
        return 'Unsupported file type';
      case '500':
        return 'Server error occurred';
      default:
        return 'File upload failed: ${e.message}';
    }
  }
}

// Custom exception class
class StorageServiceException implements Exception {
  final String message;
  StorageServiceException(this.message);
}

// class SupabaseStorage implements StorageService {
//   Supabase supabase = Supabase.instance;

//   @override
//   Future<String> uploadImageToFirebase(File imageFile, String path) async {
//     int now = DateTime.now().microsecondsSinceEpoch;
//     String fileName = p.basenameWithoutExtension(imageFile.path); // بدون امتداد

//     await supabase.client.storage
//         .from('true_gym_assets')
//         .upload('$path/$fileName$now', imageFile);

//     String url = supabase.client.storage
//         .from('true_gym_assets')
//         .getPublicUrl('$path/$fileName$now');

//     return url;
//   }

//   @override
//   Future<String> uploadaudioToFirebase(File audioFile, String path) async {
//     int now = DateTime.now().microsecondsSinceEpoch;
//     String fileName = p.basenameWithoutExtension(audioFile.path); // بدون امتداد
//     await supabase.client.storage
//         .from('true_gym_assets')
//         .upload('$path/$fileName$now', audioFile);

//     String url = supabase.client.storage
//         .from('true_gym_assets')
//         .getPublicUrl('$path/$fileName$now');

//     return url;
//   }
// }
