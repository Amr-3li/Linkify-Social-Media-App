import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_friends_state.dart';

class GetFriendsCubit extends Cubit<GetFriendsState> {
  GetFriendsCubit() : super(GetFriendsInitial());
}
