import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class CurrentlyReadingBottomSheetViewModel extends BaseViewModel {
  Logger log;

  CurrentlyReadingBottomSheetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  handleStartUpLogic({
    @required String bookId,
    @required String bookPreviewLink,
    @required String bookImage,
    @required String bookAuthors,
    @required String bookTitle,
    @required int bookTotalPages,
    @required int bookCurrentlyReachedPages,
    @required int numberOfTimesBookRead,
    @required String outlinedButtonText,
  }) {
    _bookId = bookId;
    _bookPreviewLink = bookPreviewLink;
    _bookImage = bookImage;
    _bookAuthors = bookAuthors;
    _bookTitle = bookTitle;
    _bookTotalPages = bookTotalPages;
    _bookCurrentlyReachedPages = bookCurrentlyReachedPages;
    _numberOfTimesBookRead = numberOfTimesBookRead;
    _outlinedButtonText = outlinedButtonText;
  }

  void outlinedButtonWidgetOnPressed({@required BuildContext context}) {
    // ! 'add book'
    if (_outlinedButtonText != null) {
      Navigator.pop(context);
      addBookToUserCurrentlyReading();
    }
  }

  void elevatedButtonWidgetOnPressed() {}

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

  String _outlinedButtonText;
  String get outlinedButtonText => _outlinedButtonText;

  int _bookTotalPages;
  int get bookTotalPages => _bookTotalPages;

  int _bookCurrentlyReachedPages;
  int get bookCurrentlyReachedPages => _bookCurrentlyReachedPages;

  int _numberOfTimesBookRead;
  int get numberOfTimesBookRead => _numberOfTimesBookRead;

  bool _switchValue = true;
  bool get switchValue => _switchValue;

  void toggleSwich({@required bool newValue}) {
    _switchValue = newValue;
    notifyListeners();
  }

  void numberPickerOnChanged({int aNumber}) {
    _bookCurrentlyReachedPages = aNumber;
    notifyListeners();
  }

  void addBookToUserCurrentlyReading() {
    _cloudFirestoreServices.addBookToUserCurrentlyReading(
      bookAuthors: _bookAuthors,
      bookCurrentlyReachedPages: _bookCurrentlyReachedPages,
      bookId: _bookId,
      bookImage: _bookImage,
      bookPreviewLink: _bookPreviewLink,
      bookTitle: _bookTitle,
      bookTotalPages: _bookTotalPages,
    );
  }
}
