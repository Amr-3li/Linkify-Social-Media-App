import 'package:get_it/get_it.dart';
import 'package:true_gym/Features/chat/data/repository/chat_repo.dart';
import 'package:true_gym/Features/chat/data/repository/chat_repo_implementation.dart';
import 'package:true_gym/Features/chat/data/web_services/chat_ser.dart';
import 'package:true_gym/Features/chat/data/web_services/chat_ser_implement.dart';
import 'package:true_gym/Features/register/data/repository/auth_repo.dart';
import 'package:true_gym/Features/register/data/repository/auth_repo_impl.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';
import 'package:true_gym/Features/register/data/repository/image_repo_impl.dart';
import 'package:true_gym/Features/register/data/repository/signup_repo.dart';
import 'package:true_gym/Features/register/data/repository/signup_repo_impl.dart';
import 'package:true_gym/Features/register/data/web_servecies/auth_ser.dart';
import 'package:true_gym/Features/register/data/web_servecies/auth_ser_imp.dart';
import 'package:true_gym/Features/register/data/web_servecies/signup_ser.dart';
import 'package:true_gym/Features/register/data/web_servecies/signup_ser_imp.dart';
import 'package:true_gym/Features/register/data/web_servecies/storage_ser.dart';
import 'package:true_gym/Features/register/data/web_servecies/supabase_storage.dart';

final gitItInstanse = GetIt.instance;

void setUpGitIt() {
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
}
