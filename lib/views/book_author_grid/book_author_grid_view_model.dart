import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/models/bookModels/booksResponseModel.dart';
import 'package:boo_vi_app/core/services/bookServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class BookAuthorGridViewModel extends BaseViewModel {
  Logger log;

  BookAuthorGridViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  BookServices _bookServices = locator<BookServices>();
  NavigationService _navigationService = locator<NavigationService>();

  Future<BooksResponse> getBooksByAuthor(String authorName) {
    return _bookServices.getBooksByAuthor(
        authorName: authorName, maxResults: 40, sortBy: 'relevance');
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
      transition: 'size',
    );
  }
}
