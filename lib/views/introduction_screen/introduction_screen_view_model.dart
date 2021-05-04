import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/router_constants.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class IntroductionScreenViewModel extends BaseViewModel {
  Logger log;

  IntroductionScreenViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();

  void pushStartUpView() {
    _navigationService.pushNamedAndRemoveUntil(startUpViewRoute);
  }
}
