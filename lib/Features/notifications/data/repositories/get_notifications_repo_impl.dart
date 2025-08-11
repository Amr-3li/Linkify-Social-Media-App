import 'package:dartz/dartz.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/Features/notifications/data/repositories/get_notifications_repo.dart';
import 'package:linkify/Features/notifications/data/services/get_notifications.dart';
import 'package:linkify/core/errors/failures.dart';

class GetNotificationsRepoImpl implements GetNotificationsRepo {
  final GetNotifications services;

  GetNotificationsRepoImpl(this.services);
  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications(
      {bool refresh = false}) async {
    try {
      final response = await services.getNotifications();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(
      String notificationId) async {
    try {
      await services.deleteNotification(notificationId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> readAllNotifications() async {
    try {
      await services.readAllNotifications();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  bool get hasMore => services.hasMore;

  @override
  void resetPagination() => services.resetPagination();
}
