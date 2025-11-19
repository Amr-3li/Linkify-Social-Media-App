import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_list_state.dart';

class PostsListCubit extends Cubit<PostsListState> {
  PostsListCubit() : super(PostsListInitial());
}
