import 'package:boo_vi_app/core/services/cloudStorageServices.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/ImageSelectorService.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/bookServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'logger.dart';

final GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setUpLocator() async {
    Logger log = getLogger('Locator Injector');
    log.d('Registering Navigation Service');
    locator.registerLazySingleton(() => NavigationService());
    log.d('Registering Dialog Service');
    locator.registerLazySingleton(() => DialogService());
    log.d('Registering Snackbar Service');
    locator.registerLazySingleton(() => SnackbarService());
    log.d('Registering Authentication Service');
    locator.registerLazySingleton(() => AuthenticationService());
    log.d('Registering Image Selector Service');
    locator.registerLazySingleton(() => ImageSelectorService());
    log.d('Registering Cloud Storage Service');
    locator.registerLazySingleton(() => CloudStorageServices());
    log.d('Registering Stream Services');
    locator.registerLazySingleton(() => StreamServices());
    log.d('Registering Book Services');
    locator.registerLazySingleton(() => BookServices());
    log.d('Registering Cloud Firestore Services');
    locator.registerLazySingleton(() => CloudFirestoreServices());
    log.d('Registering Authentication Service');
    locator.registerLazySingleton(() => ThemeService.getInstance());
  }
}
