// ignore_for_file: must_be_immutable

part of 'get_notifications_cubit.dart';

@immutable
sealed class GetNotificationsState {}

final class GetNotificationsInitial extends GetNotificationsState {}

final class GetNotificationsSuccess extends GetNotificationsState {
  final List<NotificationModel> notifications;
  GetNotificationsSuccess(this.notifications);
}

final class GetNotificationsFaild extends GetNotificationsState {
  String message;
  GetNotificationsFaild(this.message);
}

final class GetNotificationsLoading extends GetNotificationsState {}
