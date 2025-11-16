import 'package:http/http.dart' as http;
import 'dart:convert';

class FCMNotificationService {
  static const String _cloudFunctionUrl =
      'https://us-central1-linkify-63769.cloudfunctions.net/sendNotification';

  static Future<void> sendNotificationToToken({
    required String targetToken,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_cloudFunctionUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'targetToken': targetToken,
          'title': title,
          'body': body,
          'data': data ?? {'type': 'general'},
        }),
      );

      if (response.statusCode == 200) {
        print('✅ Notification sent successfully');
      } else {
        print('❌ Failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('⚠️ Error sending notification: $e');
    }
  }
}
