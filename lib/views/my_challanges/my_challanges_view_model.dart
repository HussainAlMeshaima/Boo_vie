import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class MyChallangesViewModel extends BaseViewModel {
  Logger log;

  MyChallangesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
