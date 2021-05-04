import 'package:boo_vi_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'core/locator.dart';
import 'core/router_constants.dart';
import 'core/router.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setUpLocator();
  await ThemeManager.initialise();
  await Firebase.initializeApp();
  runApp(MyApp());

  print('**** App is running ****');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor:
            Theme.of(context).brightness == Brightness.dark
                ? Color(0xff2E2E2E)
                : Colors.white));
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.system,
      themes: getThemes(context),
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.Router.generateRoute,
        initialRoute: introductionScreenViewRoute,
      ),
    );
  }
}
