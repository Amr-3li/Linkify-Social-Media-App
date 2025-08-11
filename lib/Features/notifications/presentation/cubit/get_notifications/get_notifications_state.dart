// ignore_for_file: must_be_immutable

part of 'get_notifications_cubit.dart';

@immutable
sealed class GetNotificationsState {}

final class GetNotificationsInitial extends GetNotificationsState {}

final class GetNotificationsSuccess extends GetNotificationsState {
  final List<NotificationModel> notifications;
  final bool isLoadingMore;
  GetNotificationsSuccess(this.notifications, {this.isLoadingMore = false});
}

final class GetNotificationsFaild extends GetNotificationsState {
  String message;
  GetNotificationsFaild(this.message);
}

final class GetNotificationsLoading extends GetNotificationsState {}

//============= Get number of unread notifications ================

final class GetUnreadNotificationsSuccess extends GetNotificationsState {
  final int noOfUnreadNotifications;
  GetUnreadNotificationsSuccess(this.noOfUnreadNotifications);
}

final class GetUnreadNotificationsFaild extends GetNotificationsState {
  String message;
  GetUnreadNotificationsFaild(this.message);
}

final class GetUnreadNotificationsLoading extends GetNotificationsState {}
