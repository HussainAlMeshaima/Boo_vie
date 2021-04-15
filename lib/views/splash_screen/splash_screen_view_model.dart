import 'dart:async';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/router_constants.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/views/login/login_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreenViewModel extends BaseViewModel {
  Logger log;

  SplashScreenViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future handleStartUpLogic() async {
    if (await _authenticationService.hasUser()) {
      _navigationService.pushNamedAndRemoveUntil(startUpViewRoute);
    } else {
      _navigationService.navigateWithTransition(LoginView(),
          duration: Duration(seconds: 1, milliseconds: 400),
          transition: 'downToUp');
    }
  }
}
