import 'package:linkify/Features/notifications/data/model/notification_model.dart';

abstract class GetNotifications {
  Future<List<NotificationModel>> getNotifications();
}
