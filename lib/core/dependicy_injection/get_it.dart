import 'package:get_it/get_it.dart';
import 'package:linkify/Features/chat/data/repository/chat_repo.dart';
import 'package:linkify/Features/chat/data/repository/chat_repo_implementation.dart';
import 'package:linkify/Features/chat/data/web_services/chat_ser.dart';
import 'package:linkify/Features/chat/data/web_services/chat_ser_implement.dart';
import 'package:linkify/Features/posts/data/repository/add_post_repo.dart';
import 'package:linkify/Features/posts/data/repository/add_post_repo_impl.dart';
import 'package:linkify/Features/posts/data/services/post_serv.dart';
import 'package:linkify/Features/posts/data/services/post_serv_impl.dart';
import 'package:linkify/Features/posts/presentation/cubit/add_post/add_post_cubit.dart';
import 'package:linkify/Features/home/presentation/cubit/get_posts/get_posts_cubit.dart';
import 'package:linkify/Features/home/presentation/cubit/post_control/post_control_cubit.dart';
import 'package:linkify/Features/register/data/repository/auth_repo.dart';
import 'package:linkify/Features/register/data/repository/auth_repo_impl.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';
import 'package:linkify/Features/register/data/repository/image_repo_impl.dart';
import 'package:linkify/Features/register/data/repository/signup_repo.dart';
import 'package:linkify/Features/register/data/repository/signup_repo_impl.dart';
import 'package:linkify/Features/register/data/web_servecies/auth_ser.dart';
import 'package:linkify/Features/register/data/web_servecies/auth_ser_imp.dart';
import 'package:linkify/Features/register/data/web_servecies/signup_ser.dart';
import 'package:linkify/Features/register/data/web_servecies/signup_ser_imp.dart';
import 'package:linkify/Features/register/data/web_servecies/storage_ser.dart';
import 'package:linkify/Features/register/data/web_servecies/supabase_storage.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo_impl.dart';
import 'package:linkify/core/shared_logic/data/services/user_data_impl.dart';
import 'package:linkify/core/shared_logic/data/services/users_data.dart';

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
  //======================= Posts ===========================================
  gitItInstanse.registerSingleton<PostServ>(PostServImpl());
  gitItInstanse
      .registerSingleton<PostRepo>(PostRepoImpl(gitItInstanse<PostServ>()));
  gitItInstanse.registerSingleton<GetPostsCubit>(
      GetPostsCubit(gitItInstanse<PostRepo>()));
  gitItInstanse.registerSingleton<PostControlCubit>(
      PostControlCubit(gitItInstanse<PostRepo>()));
  gitItInstanse.registerSingleton<AddPostCubit>(
      AddPostCubit(gitItInstanse<PostRepo>(), gitItInstanse<ImageRepo>()));
}
