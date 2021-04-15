import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/bookServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class BookInformationViewModel extends BaseViewModel {
  Logger log;

  BookInformationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  BookServices _bookServices = locator<BookServices>();
  getBookById({@required String id}) {
    return _bookServices.getBookById(volumeId: id);
  }

  String getAuthors(List<String> authors) {
    String authorsString;

    if (authors == null)
      authorsString = 'No Authors For this Book';
    else if (authors.length == 0) {
      authorsString = 'No Authors For this Book';
    } else if (authors.length == 1) {
      authorsString = authors[0];
    } else {
      var concatenate = StringBuffer();
      authors.forEach((item) {
        concatenate.write(item + ',  ');
      });
      return concatenate.toString();
    }
    return authorsString.toString();
  }

  String getCategories(List<String> categories) {
    String getCategoriesString;

    if (categories == null)
      getCategoriesString = 'No Categories For this Book';
    else if (categories.length == 0) {
      getCategoriesString = 'No Authors For this Book';
    } else if (categories.length == 1) {
      getCategoriesString = categories[0];
    } else {
      var concatenate = StringBuffer();
      categories.forEach((item) {
        concatenate.write(item + ',  ');
      });
      return concatenate.toString();
    }
    return getCategoriesString.toString();
  }
}
