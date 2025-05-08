import 'package:bloc/bloc.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/Features/notifications/data/repositories/get_notifications_repo.dart';
import 'package:meta/meta.dart';

part 'get_notifications_state.dart';

class GetNotificationsCubit extends Cubit<GetNotificationsState> {
  GetNotificationsCubit(this.repo) : super(GetNotificationsInitial());
  final GetNotificationsRepo repo;

  Future<void> getNotifications() async {
    emit(GetNotificationsLoading());
    final response = await repo.getNotifications();

    response.fold(
      (l) => emit(GetNotificationsFaild(l.errMessage)),
      (r) => emit(GetNotificationsSuccess(r)),
    );
  }
}
