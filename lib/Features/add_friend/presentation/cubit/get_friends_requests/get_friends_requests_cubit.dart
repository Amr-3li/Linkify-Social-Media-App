import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_friends_requests_state.dart';

class GetFriendsRequestsCubit extends Cubit<GetFriendsRequestsState> {
  GetFriendsRequestsCubit() : super(GetFriendsRequestsInitial());
}
