import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:true_gym/Features/register/data/web_servecies/storage_ser.dart';
import 'package:path/path.dart' as p;

class SupabaseStorage implements StorageService {
  Supabase supabase = Supabase.instance;
  @override
  Future<String> uploadImageToFirebase(File imageFile, String path) async {
    String fileName = p.basename(imageFile.path);
    String extension = p.extension(imageFile.path);
    await supabase.client.storage
        .from('true_gym_assets')
        .upload('$path/$fileName.$extension', imageFile);
    String url = supabase.client.storage
        .from('true_gym_assets')
        .getPublicUrl('$path/$fileName.$extension');
    return url;
  }
}
