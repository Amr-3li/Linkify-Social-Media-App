import 'package:get_it/get_it.dart';
import 'package:linkify/Features/my_lists/data/repo/get_posts_list_repo.dart';
import 'package:linkify/Features/my_lists/data/repo/get_posts_list_repo_impl.dart';
import 'package:linkify/Features/my_lists/data/web_services/get_posts_list.dart';
import 'package:linkify/Features/my_lists/data/web_services/get_posts_list_impl.dart';

import 'package:linkify/core/exports/di.dart';

final gitItInstanse = GetIt.instance;

void setUpGitIt() {
  //========================User data ===============================

  gitItInstanse.registerSingleton<UsersData>(UserDataImpl());
  gitItInstanse.registerSingleton<UserDataRepo>(
      UserDataRepoImpl(gitItInstanse<UsersData>()));

  //======================== Auth ===================================

  gitItInstanse.registerSingleton<AuthService>(AuthWebServiceImplement());
  gitItInstanse.registerSingleton<AuthRepository>(
      AuthRepoImpelement(gitItInstanse<AuthService>()));
  gitItInstanse.registerSingleton<SignupService>(SignupSerImplementation());
  gitItInstanse.registerSingleton<SignupRepo>(
      SignupRepoImplement(gitItInstanse<SignupService>()));
  gitItInstanse.registerSingleton<StorageService>(SupabaseStorage());
  gitItInstanse.registerSingleton<ImageRepo>(
      ImageRepoImpl(gitItInstanse<StorageService>()));

  //======================= chat==============================================

  gitItInstanse.registerSingleton<ChatSer>(ChatSerImplement());
  gitItInstanse.registerSingleton<ChatRepo>(
      ChatRepoImplementation(gitItInstanse<ChatSer>()));

  gitItInstanse.registerSingleton<ChatUsers>(ChatUsersImpl());
  gitItInstanse.registerSingleton<ChatUsersRepo>(
      ChatUsersRepoImpl(gitItInstanse<ChatUsers>()));

  //======================= Posts ===========================================

  gitItInstanse.registerSingleton<AddPost>(AddPostImpl());
  gitItInstanse.registerSingleton<AddPostRepo>(
      AddPostRepoImpl(gitItInstanse<AddPost>()));

  gitItInstanse.registerSingleton<PostControl>(PostControlImpl());
  gitItInstanse.registerSingleton<PostControlRepo>(
      PostControlRepoImpl(gitItInstanse<PostControl>()));

  gitItInstanse.registerSingleton<GetPostsServ>(GetPostsServImpl());
  gitItInstanse.registerSingleton<GetPostRepo>(
      GetPostsRepoImpl(gitItInstanse<GetPostsServ>()));

  gitItInstanse.registerSingleton<GetPostsCubit>(
      GetPostsCubit(gitItInstanse<GetPostRepo>()));
  gitItInstanse.registerSingleton<GetPostLoversCubit>(
      GetPostLoversCubit(gitItInstanse<GetPostRepo>()));
  gitItInstanse.registerLazySingleton<GetPostCommentsCubit>(
      () => GetPostCommentsCubit(gitItInstanse<GetPostRepo>()));

  gitItInstanse.registerSingleton<GetUserPosts>(GetUserPostsImpl());
  gitItInstanse.registerSingleton<GetUserPostsRepo>(
      GetUserPostsRepoImpl(gitItInstanse<GetUserPosts>()));

  gitItInstanse.registerSingleton<GetPostsList>(GetPostsListImpl());
  gitItInstanse.registerSingleton<GetPostsListRepo>(
      GetPostsListRepoImpl(gitItInstanse<GetPostsList>()));
//======================= Search ===========================================

  gitItInstanse.registerSingleton<GetSearchUsers>(GetSearchUsersImpl());
  gitItInstanse.registerSingleton<GetSearchUsersRepo>(
      GetSearchUsersRepoImpl(gitItInstanse<GetSearchUsers>()));

  //=========================== friends ===============================================

  gitItInstanse.registerSingleton<FriendServ>(AddFriendServImpl());
  gitItInstanse.registerSingleton<FriendsRepo>(
      FrierndsRepoImpl(gitItInstanse<FriendServ>()));

  gitItInstanse
      .registerSingleton<GetFriendsOrRequests>(GetFriendsOrRequestsImpl());
  gitItInstanse.registerSingleton<GetFriendsOrRequestsRepo>(
      GetFriendsOrRequestsRepoImpl(gitItInstanse<GetFriendsOrRequests>()));

  gitItInstanse.registerSingleton<GetUserStatus>(GetUserStatusImpl());
  gitItInstanse.registerSingleton<GetUserStatusRepo>(
      GetUserStatusRepoImpl(gitItInstanse<GetUserStatus>()));

  //=========================== notifications ===============================================

  gitItInstanse.registerSingleton<GetNotifications>(GetNotificationsImpl());
  gitItInstanse.registerSingleton<GetNotificationsRepo>(
      GetNotificationsRepoImpl(gitItInstanse<GetNotifications>()));
  //============================ settings ==============================================
  gitItInstanse.registerSingleton<ResetPass>(ResetPassImpl());
  gitItInstanse.registerSingleton<ResetPassRepo>(
      ResetPassRepoImpl(gitItInstanse<ResetPass>()));
}
