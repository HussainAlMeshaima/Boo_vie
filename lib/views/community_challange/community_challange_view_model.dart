import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class CommunityChallangeViewModel extends BaseViewModel {
  Logger log;

  CommunityChallangeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  NavigationService _navigationService = locator<NavigationService>();

  void pushBookView() {
    _navigationService.navigateWithTransition(
        BookView(
          authors: _challengeAuthors,
          id: _bookId,
          image: _challengeImage,
          text: _bookTitle,
          previewLink: _previewLink,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  String _challangeType;
  String get challangeType => _challangeType;

  String _challangeId;
  String get challangeId => _challangeId;

  String _bookId;
  String get bookId => _bookId;

  String _challengeImage;
  String get image => _challengeImage;

  String _challengeAuthors;
  String get challengeAuthors => _challengeAuthors;

  String _challengeName;
  String get challengeName => _challengeName;

  String _previewLink;
  String get previewLink => _previewLink;

  String _bookTitle;
  String get bookTitle => _bookTitle;

  Timestamp _setToDate;
  Timestamp get setToDate => _setToDate;

  String _numberOfdays;
  String get numberOfdays => _numberOfdays;

  String _numberOfhours;
  String get numberOfhours => _numberOfhours;

  String _numberOfminutes;
  String get numberOfminutes => _numberOfminutes;

  String _numberOfseconds;
  String get numberOfseconds => _numberOfseconds;

  String _challengeDiscription;
  String get challengeDiscription => _challengeDiscription;

  List _challengeRules;
  List get challengeRules => _challengeRules;

  handleStartUpLogic({
    @required String challangeType,
    @required String challangeId,
    @required String bookId,
    @required String challengeImage,
    @required String challengeAuthors,
    @required String challengeName,
    @required String previewLink,
    @required String bookTitle,
    @required Timestamp setToDate,
    @required String challengeDiscription,
    @required List challengeRules,
  }) {
    _challangeType = challangeType;
    _bookTitle = bookTitle;
    _bookId = bookId;
    _previewLink = previewLink;
    //-----------------------------------------------------------
    _challangeId = challangeId;
    _challengeName = challengeName;
    _challengeImage = challengeImage;
    _challengeAuthors = challengeAuthors;
    _challengeDiscription = challengeDiscription;
    _challengeRules = challengeRules;
    //-----------------------------------------------------------

    //-----------------------------------------------------------
    _setToDate = setToDate;
  }
}
