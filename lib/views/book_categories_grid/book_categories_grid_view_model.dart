import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/models/bookModels/booksResponseModel.dart';
import 'package:boo_vi_app/core/services/bookServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class BookCategoriesGridViewModel extends BaseViewModel {
  Logger log;

  BookCategoriesGridViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  BookServices _bookServices = locator<BookServices>();
  NavigationService _navigationService = locator<NavigationService>();

  Future<BooksResponse> getBooksBycategories(String categories) {
    String char;

    for (int i = 0; i < categories.length; i++) {
      char = categories.substring(i, i + 1);
      if (char == ' ') {
        categories = categories.substring(0, i);
        print(char);
        break;
      }
    }

    return _bookServices.getBooksByCategories(
        categoriesName: categories, maxResults: 40, sortBy: 'relevance');
  }

  pushBookView(
      {@required String id,
      @required String image,
      @required String bookTitle,
      @required String previewLink}) {
    _navigationService.navigateWithTransition(
        BookView(
          id: id,
          image: image,
          text: bookTitle,
          previewLink: previewLink,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  String _newCategoriesName;
  String get newCategoriesName => _newCategoriesName;

  handleStartUpLogic(String categories) {
    String char;

    for (int i = 0; i < categories.length; i++) {
      char = categories.substring(i, i + 1);
      if (char == ' ') {
        _newCategoriesName = categories.substring(0, i);
        print(char);
        break;
      }
    }
    _newCategoriesName = _newCategoriesName;
    return _newCategoriesName;
  }
}
