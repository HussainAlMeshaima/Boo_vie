import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ElevatedButtonViewModel extends BaseViewModel {
  Logger log;

  ElevatedButtonViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
