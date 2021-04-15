import 'package:boo_vi_app/core/locator.dart';
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
    print(_text);
    _navigationService.navigateWithTransition(
        SearchedView(
            timedText: _text, noneTrimedText: _searchTextfieldController.text),
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

  TextEditingController _searchTextfieldController =
      TextEditingController(text: '');
  TextEditingController get searchTextfieldController =>
      _searchTextfieldController;
}
