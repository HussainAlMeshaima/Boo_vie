import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class TextfieldViewModel extends BaseViewModel {
  Logger log;

  TextfieldViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
