import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class GlobalChallengeViewModel extends BaseViewModel {
  Logger log;

  GlobalChallengeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
