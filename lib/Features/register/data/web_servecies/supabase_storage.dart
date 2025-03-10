import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:linkify/Features/register/data/web_servecies/storage_ser.dart';
import 'package:path/path.dart' as p;

class SupabaseStorage implements StorageService {
  Supabase supabase = Supabase.instance;

  @override
  Future<String> uploadImageToFirebase(File imageFile, String path) async {
    int now = DateTime.now().microsecondsSinceEpoch;
    String fileName = p.basenameWithoutExtension(imageFile.path); // بدون امتداد

    await supabase.client.storage
        .from('true_gym_assets')
        .upload('$path/$fileName$now', imageFile);

    String url = supabase.client.storage
        .from('true_gym_assets')
        .getPublicUrl('$path/$fileName$now');

    return url;
  }

  @override
  Future<String> uploadaudioToFirebase(File audioFile, String path) async {
    int now = DateTime.now().microsecondsSinceEpoch;
    String fileName = p.basenameWithoutExtension(audioFile.path); // بدون امتداد
    await supabase.client.storage
        .from('true_gym_assets')
        .upload('$path/$fileName$now', audioFile);

    String url = supabase.client.storage
        .from('true_gym_assets')
        .getPublicUrl('$path/$fileName$now');

    return url;
  }
}
