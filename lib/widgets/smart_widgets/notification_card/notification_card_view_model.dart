import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class NotificationCardViewModel extends BaseViewModel {
  Logger log;

  NotificationCardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
