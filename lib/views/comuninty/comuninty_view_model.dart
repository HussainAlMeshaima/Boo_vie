import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ComunintyViewModel extends BaseViewModel {
  Logger log;

  ComunintyViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
