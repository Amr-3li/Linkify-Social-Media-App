import 'package:dartz/dartz.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class GetNotificationsRepo {
  bool get hasMore;
  Future<Either<Failure, List<NotificationModel>>> getNotifications(
      {bool refresh = false});
  void resetPagination();
}
