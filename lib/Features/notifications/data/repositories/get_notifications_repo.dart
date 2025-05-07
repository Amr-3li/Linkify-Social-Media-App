import 'package:dartz/dartz.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class GetNotificationsRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
}
