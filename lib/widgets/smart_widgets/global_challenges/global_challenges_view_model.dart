import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class GlobalChallengesViewModel extends BaseViewModel {
  Logger log;

  GlobalChallengesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
