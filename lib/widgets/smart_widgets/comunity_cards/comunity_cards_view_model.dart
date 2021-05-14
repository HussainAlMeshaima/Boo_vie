import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ComunityCardsViewModel extends BaseViewModel {
  Logger log;

  ComunityCardsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
