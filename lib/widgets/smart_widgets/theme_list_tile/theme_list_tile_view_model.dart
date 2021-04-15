import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ThemeListTileViewModel extends BaseViewModel {
  Logger log;

  ThemeListTileViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
