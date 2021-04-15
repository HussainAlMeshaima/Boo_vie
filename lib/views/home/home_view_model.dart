import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:boo_vi_app/views/more_books/more_books_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  Logger log;

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  StreamServices _streamServices = locator<StreamServices>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future<DocumentSnapshot> getUserCategories() async {
    return _streamServices
        .getUserCategories(await _authenticationService.userEmail());
  }

  pushMoreBooksView({Stream stream, String text}) {
    _navigationService.navigateWithTransition(
        MoreBooksView(
          stream: stream,
          text: text,
        ),
        transition: 'rightToLeftWithFade');
  }

  pushBookView(
      {String id, String image, String bookTitle, String previewLink}) {
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

  Stream getComicBooksStream() {
    return _streamServices.getComicBooksStream();
  }

  Stream getFullNewestBooksStream() {
    return _streamServices.getFullNewestBooksStream();
  }

  Stream getNewestBooksStream() {
    return _streamServices.getNewestBooksStream();
  }

  Stream getfullComicBooksStream() {
    return _streamServices.getfullComicBooksStream();
  }

  Stream getTravelBooksStream() {
    return _streamServices.getTravelBooksStream();
  }

  Stream getFullArtsAndentErtainmentBooksStream() {
    return _streamServices.getFullArtsAndentErtainmentBooksStream();
  }

  Stream getArtsAndentErtainmentBooksStream() {
    return _streamServices.getArtsAndentErtainmentBooksStream();
  }

  Stream getFullTravelBooksStream() {
    return _streamServices.getFullTravelBooksStream();
  }

  Stream getFullHistoryBooksStream() {
    return _streamServices.getFullHistoryBooksStream();
  }

  Stream getHistoryBooksStream() {
    return _streamServices.getHistoryBooksStream();
  }

  Stream getFullBiographiesAndMemoirsBooksStream() {
    return _streamServices.getFullBiographiesAndMemoirsBooksStream();
  }

  Stream getBiographiesAndMemoirsBooksStream() {
    return _streamServices.getBiographiesAndMemoirsBooksStream();
  }
}
