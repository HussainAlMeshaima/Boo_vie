import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class DoorType1ViewModel extends BaseViewModel {
  Logger log;

  DoorType1ViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
