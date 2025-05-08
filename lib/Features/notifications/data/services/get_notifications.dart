import 'package:linkify/Features/notifications/data/model/notification_model.dart';

abstract class GetNotifications {
  bool get hasMore;
  Future<List<NotificationModel>> getNotifications({bool refresh = false});
  void resetPagination();
}
