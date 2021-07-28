import 'package:get_it/get_it.dart';

import 'data/services/auth.dart';
import 'data/services/database.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => AuthService());
}
