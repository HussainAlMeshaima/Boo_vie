import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ComunintyInformationViewModel extends BaseViewModel {
  Logger log;

  ComunintyInformationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
