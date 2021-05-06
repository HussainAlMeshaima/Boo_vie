import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/Views/more_books/more_books_view.dart';
import 'package:boo_vi_app/Views/searched/searched_view.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends BaseViewModel {
  Logger log;

  SearchViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  StreamServices _streamServices = locator<StreamServices>();
  NavigationService _navigationService = locator<NavigationService>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  pushMoreBooksView({Stream stream, String text}) {
    _navigationService.navigateWithTransition(
        MoreBooksView(
          stream: stream,
          text: text,
        ),
        transition: 'rightToLeftWithFade');
  }

  Future addAbookToRecentlyViewedShelf({
    @required String bookId,
    @required String bookImage,
    @required String previewLink,
    @required String title,
    @required String authors,
  }) async {
    await _cloudFirestoreServices.addAbookToRecentlyViewedShelf(
        bookId: bookId,
        authors: authors,
        title: title,
        previewLink: previewLink,
        bookImage: bookImage);
  }

  pushBookView(
      {@required String id,
      @required String image,
      @required String bookTitle,
      @required String previewLink,
      @required String authors}) {
    _navigationService.navigateWithTransition(
        BookView(
          authors: authors,
          id: id,
          image: image,
          text: bookTitle,
          previewLink: previewLink,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  pushSearchedView({@required BuildContext context}) {
    String _text;
    if (_searchTextfieldController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Search cannot be empty'),
        ),
      );
    }
    _text = _searchTextfieldController.text
        .trim()
        .trimLeft()
        .trimRight()
        .replaceAll(' ', '+');

    _navigationService.navigateWithTransition(
        SearchedView(
            timedText: _text, noneTrimedText: _searchTextfieldController.text),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  Stream getFullArtsAndentErtainmentBooksStream() {
    return _streamServices.getFullArtsAndentErtainmentBooksStream();
  }

  Stream getArtsAndentErtainmentBooksStream() {
    return _streamServices.getArtsAndentErtainmentBooksStream();
  }

  Stream getFullBiographiesAndMemoirsBooksStream() {
    return _streamServices.getFullBiographiesAndMemoirsBooksStream();
  }

  Stream getBiographiesAndMemoirsBooksStream() {
    return _streamServices.getBiographiesAndMemoirsBooksStream();
  }

  Stream getFullBusinessAndInvestingBooksStream() {
    return _streamServices.getFullBusinessAndInvestingBooksStream();
  }

  Stream getBusinessAndInvestingBooksStream() {
    return _streamServices.getBusinessAndInvestingBooksStream();
  }

  Stream getFullChildrensBooksStream() {
    return _streamServices.getFullChildrensBooksStream();
  }

  Stream getChildrensBooksStream() {
    return _streamServices.getChildrensBooksStream();
  }

  Stream getComicBooksStream() {
    return _streamServices.getComicBooksStream();
  }

  Stream getFullComicBooksStream() {
    return _streamServices.getFullComicBooksStream();
  }

  Stream getFullComputersAndTechnologyBooksStream() {
    return _streamServices.getFullComputersAndTechnologyBooksStream();
  }

  Stream getComputersAndTechnologyBooksStream() {
    return _streamServices.getComputersAndTechnologyBooksStream();
  }

  Stream getFullCookingAndFoodBooksStream() {
    return _streamServices.getFullCookingAndFoodBooksStream();
  }

  Stream getCookingAndFoodBooksStream() {
    return _streamServices.getCookingAndFoodBooksStream();
  }

  Stream getFullFictionAndLiteratureBooksStream() {
    return _streamServices.getFullFictionAndLiteratureBooksStream();
  }

  Stream getFictionAndLiteratureBooksStream() {
    return _streamServices.getFictionAndLiteratureBooksStream();
  }

  Stream getFullHealthMindAndbodyBooksStream() {
    return _streamServices.getFullHealthMindAndbodyBooksStream();
  }

  Stream getHealthMindAndbodyBooksStream() {
    return _streamServices.getHealthMindAndbodyBooksStream();
  }

  Stream getFullHistoryBooksStream() {
    return _streamServices.getFullHistoryBooksStream();
  }

  Stream getHistoryBooksStream() {
    return _streamServices.getHistoryBooksStream();
  }

  Stream getFullHomeAndGardenBooksStream() {
    return _streamServices.getFullHomeAndGardenBooksStream();
  }

  Stream getHomeAndGardenBooksStream() {
    return _streamServices.getHomeAndGardenBooksStream();
  }

  Stream getFullMysteryAndThrillersBooksStream() {
    return _streamServices.getFullMysteryAndThrillersBooksStream();
  }

  Stream getMysteryAndThrillersBooksStream() {
    return _streamServices.getMysteryAndThrillersBooksStream();
  }

  Stream getFullScienceFictionAndFantasyBooksStream() {
    return _streamServices.getFullScienceFictionAndFantasyBooksStream();
  }

  Stream getScienceFictionAndFantasyBooksStream() {
    return _streamServices.getScienceFictionAndFantasyBooksStream();
  }

  Stream getFullSportsBooksStream() {
    return _streamServices.getFullSportsBooksStream();
  }

  Stream getSportsBooksStream() {
    return _streamServices.getSportsBooksStream();
  }

  Stream getTravelBooksStream() {
    return _streamServices.getTravelBooksStream();
  }

  Stream getFullTravelBooksStream() {
    return _streamServices.getFullTravelBooksStream();
  }

  TextEditingController _searchTextfieldController =
      TextEditingController(text: '');
  TextEditingController get searchTextfieldController =>
      _searchTextfieldController;
}
