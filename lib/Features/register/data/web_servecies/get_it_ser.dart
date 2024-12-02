import 'package:get_it/get_it.dart';
import 'package:true_gym/Features/register/data/repository/auth_repo.dart';
import 'package:true_gym/Features/register/data/repository/auth_repo_impl.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';
import 'package:true_gym/Features/register/data/repository/image_repo_impl.dart';
import 'package:true_gym/Features/register/data/repository/signup_repo.dart';
import 'package:true_gym/Features/register/data/repository/signup_repo_impl.dart';
import 'package:true_gym/Features/register/data/web_servecies/auth_ser.dart';
import 'package:true_gym/Features/register/data/web_servecies/auth_ser_imp.dart';
import 'package:true_gym/Features/register/data/web_servecies/fire_storage.dart';
import 'package:true_gym/Features/register/data/web_servecies/signup_ser.dart';
import 'package:true_gym/Features/register/data/web_servecies/signup_ser_imp.dart';
import 'package:true_gym/Features/register/data/web_servecies/storage_ser.dart';
import 'package:true_gym/Features/register/data/web_servecies/supabase_storage.dart';

final gitItAuth = GetIt.instance;
void setUpGitIt() {
  gitItAuth.registerSingleton<AuthService>(AuthWebServiceImplement());
  gitItAuth.registerSingleton<AuthRepository>(
      AuthRepoImpelement(gitItAuth<AuthService>()));
  gitItAuth.registerSingleton<SignupService>(SignupSerImplementation());
  gitItAuth.registerSingleton<SignupRepo>(
      SignupRepoImplement(gitItAuth<SignupService>()));
  gitItAuth.registerSingleton<StorageService>(SupabaseStorage());
  gitItAuth
      .registerSingleton<ImageRepo>(ImageRepoImpl(gitItAuth<StorageService>()));
}
