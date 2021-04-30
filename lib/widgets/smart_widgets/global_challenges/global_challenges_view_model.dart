import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/views/global_challenge/global_challenge_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class GlobalChallengesViewModel extends BaseViewModel {
  Logger log;

  GlobalChallengesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();

  pushGlobalChallengeView() {
    _navigationService.navigateWithTransition(GlobalChallengeView(),
        transition: 'rightToLeftWithFade');
  }
}
