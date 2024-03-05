import 'package:get_it/get_it.dart';
import 'package:signup_page/Module/get_it_demo/repo/post_repo.dart';

final locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => PostRepo());
}