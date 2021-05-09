import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/views/room/room_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ComunintyInformationViewModel extends BaseViewModel {
  Logger log;

  ComunintyInformationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  NavigationService _navigationService = locator<NavigationService>();

  pushRoom() {
    _navigationService.navigateWithTransition(
        RoomView(
          roomId: '123',
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }
}
