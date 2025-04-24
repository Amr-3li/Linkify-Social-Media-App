import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit() : super(FriendsInitial());
}
