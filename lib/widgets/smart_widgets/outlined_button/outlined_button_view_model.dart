import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class OutlinedButtonViewModel extends BaseViewModel {
  Logger log;

  OutlinedButtonViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
