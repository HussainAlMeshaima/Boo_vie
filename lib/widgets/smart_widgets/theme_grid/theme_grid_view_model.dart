import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ThemeGridViewModel extends BaseViewModel {
  Logger log;

  ThemeGridViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
