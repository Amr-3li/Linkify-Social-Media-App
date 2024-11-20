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

final gitIt = GetIt.instance;
void setUpGitIt() {
  gitIt.registerSingleton<AuthService>(AuthWebServiceImplement());
  gitIt.registerSingleton<AuthRepository>(
      AuthRepoImpelement(gitIt<AuthService>()));
  gitIt.registerSingleton<SignupService>(SignupSerImplementation());
  gitIt.registerSingleton<SignupRepo>(
      SignupRepoImplement(gitIt<SignupService>()));
  gitIt.registerSingleton<StorageService>(FireStorage());
  gitIt.registerSingleton<ImageRepo>(ImageRepoImpl(gitIt<StorageService>()));
}
