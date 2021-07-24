import 'package:get_it/get_it.dart';

import 'data/services/database.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() {
    final databaseService = DatabaseService();
    databaseService.initialize();
    return databaseService;
  });
}
