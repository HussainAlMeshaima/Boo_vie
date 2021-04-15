import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class BookAuthorAndNameViewModel extends BaseViewModel {
  Logger log;

  BookAuthorAndNameViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
