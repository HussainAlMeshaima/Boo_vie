import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class CurrentlyReadingViewModel extends BaseViewModel {
  Logger log;

  CurrentlyReadingViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();

  pushBookView() {
    _navigationService.navigateWithTransition(
        BookView(
          authors: _bookAuthors,
          id: _bookId,
          image: _bookImage,
          text: bookTitle,
          previewLink: _bookPreviewLink,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  handleStartUpLogic({
    @required String bookId,
    @required String bookPreviewLink,
    @required String bookImage,
    @required String bookAuthors,
    @required String bookTitle,
    @required int bookTotalPages,
    @required int bookCurrentlyReachedPages,
    @required int numberOfTimesBookRead,
  }) {
    _bookId = bookId;
    _bookPreviewLink = bookPreviewLink;
    _bookImage = bookImage;
    _bookAuthors = bookAuthors;
    _bookTitle = bookTitle;
    _bookTotalPages = bookTotalPages;
    _bookCurrentlyReachedPages = bookCurrentlyReachedPages;
    _numberOfTimesBookRead = numberOfTimesBookRead;
  }

  String _bookId;
  String get bookId => _bookId;

  String _bookPreviewLink;
  String get bookPreviewLink => _bookPreviewLink;

  String _bookImage;
  String get bookImage => _bookImage;

  String _bookAuthors;
  String get bookAuthors => _bookAuthors;

  String _bookTitle;
  String get bookTitle => _bookTitle;

  int _bookTotalPages;
  int get bookTotalPages => _bookTotalPages;

  int _bookCurrentlyReachedPages;
  int get bookCurrentlyReachedPages => _bookCurrentlyReachedPages;

  int _numberOfTimesBookRead;
  int get numberOfTimesBookRead => _numberOfTimesBookRead;
}
