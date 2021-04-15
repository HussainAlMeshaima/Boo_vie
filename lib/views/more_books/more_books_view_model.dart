import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class MoreBooksViewModel extends BaseViewModel {
  Logger log;

  MoreBooksViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();

  pushBookView(
      {String id, String image, String bookTitle, String previewLink}) {
    _navigationService.navigateWithTransition(
        BookView(
          id: id,
          image: image,
          text: bookTitle,
          previewLink: previewLink,
        ),
        transition: 'fade',
        duration: Duration(milliseconds: 460));
  }
}
