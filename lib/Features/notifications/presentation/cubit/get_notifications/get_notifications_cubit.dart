import 'package:bloc/bloc.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/Features/notifications/data/repositories/get_notifications_repo.dart';
import 'package:meta/meta.dart';

part 'get_notifications_state.dart';

class GetNotificationsCubit extends Cubit<GetNotificationsState> {
  GetNotificationsCubit(this.repo) : super(GetNotificationsInitial());
  final GetNotificationsRepo repo;
  List<NotificationModel> _notifications = [];
  bool _isLoadingMore = false;
  Future<void> loadInitialNotifications() async {
    emit(GetNotificationsLoading());
    repo.resetPagination();
    try {
      final response = await repo.getNotifications(refresh: true);
      response.fold(
        (l) => emit(GetNotificationsFaild(l.errMessage)),
        (r) {
          _notifications = r;
          emit(GetNotificationsSuccess(_notifications, isLoadingMore: false));
        },
      );
    } catch (e) {
      emit(GetNotificationsFaild(e.toString()));
    }
  }

  Future<void> loadMoreNotifications() async {
    if (_isLoadingMore || !repo.hasMore) return;
    _isLoadingMore = true;
    emit(GetNotificationsSuccess(_notifications, isLoadingMore: true));

    final response = await repo.getNotifications();
    response.fold(
      (l) => emit(GetNotificationsFaild(l.errMessage)),
      (r) {
        _notifications.addAll(r);
        _isLoadingMore = false;
        emit(GetNotificationsSuccess(_notifications, isLoadingMore: false));
      },
    );
  }

  Future<void> deleteNotification(String notificationId) async {
    await repo.deleteNotification(notificationId);
    loadInitialNotifications();
  }

  Future<void> readAllNotifications() async {
    await repo.readAllNotifications();

    loadInitialNotifications();
  }

  Future<void> noOfUnreadNotifications() async {
    final response = await repo.noOfUnreadNotifications();
    response.fold((l) => emit(GetUnreadNotificationsFaild(l.errMessage)), (r) {
      emit(GetUnreadNotificationsSuccess(r));
    });
  }
}
