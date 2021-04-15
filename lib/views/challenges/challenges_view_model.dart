import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ChallengesViewModel extends BaseViewModel {
  Logger log;

  ChallengesViewModel() {
    log = getLogger(this.runtimeType.toString());
  }
}
