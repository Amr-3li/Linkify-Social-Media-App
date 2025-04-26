import 'package:bloc/bloc.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:meta/meta.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit() : super(FriendsInitial());
}
