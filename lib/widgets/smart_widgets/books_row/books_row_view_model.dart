import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class BooksRowViewModel extends BaseViewModel {
  Logger log;

  BooksRowViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
