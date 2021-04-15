import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class UnderlineTextViewModel extends BaseViewModel {
  Logger log;

  UnderlineTextViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
