import 'package:get_it/get_it.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';
import 'package:true_gym/Features/register/data/web_servecies/fire_storage.dart';
import 'package:true_gym/Features/register/data/web_servecies/storage_ser.dart';

final gitIt = GetIt.instance;
void setUpGitIt() {
  gitIt.registerSingleton<StorageService>(FireStorage());
  gitIt.registerSingleton<ImageRepo>(ImageRepo(gitIt<StorageService>()));
}
