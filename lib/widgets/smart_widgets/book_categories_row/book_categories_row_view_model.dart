import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class BookCategoriesRowWidgetViewModel extends BaseViewModel {
  Logger log;

  BookCategoriesRowWidgetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
