import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class MoreBooksViewModel extends BaseViewModel {
  Logger log;

  MoreBooksViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
