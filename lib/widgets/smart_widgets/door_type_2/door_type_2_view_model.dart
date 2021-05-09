import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class DoorType2ViewModel extends BaseViewModel {
  Logger log;

  DoorType2ViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
