import 'dart:async';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class UserGlobalChallengeViewModel extends BaseViewModel {
  Logger log;

  UserGlobalChallengeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  handleStartUpLogic(
      {String challangeId,
      String bookId,
      String challengeImage,
      String challengeAuthors,
      String challengeName,
      String previewLink,
      String bookTitle,
      Timestamp setToDate,
      String challengeDiscription,
      Map trophiesMap,
      List challengeRules}) {
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
    _trophiesMap = trophiesMap;
    //-----------------------------------------------------------
    _setToDate = setToDate;

    convertTheGivenTimestampToString();

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      convertTheGivenTimestampToString();

      notifyListeners();
    });
  }

  void convertTheGivenTimestampToString() {
    DateTime otherDate = _setToDate.toDate();

    Duration date = otherDate.difference(DateTime.now());

    int _days = date.inDays;
    int _hours = date.inHours % 24;
    int _minutes = date.inMinutes % 60;
    int _seconds = date.inSeconds % 60;

    String _daysString = '$_days';
    String _hoursString = '$_hours'.padLeft(2, '0');
    String _minutesString = '$_minutes'.padLeft(2, '0');
    String _secondsString = '$_seconds'.padLeft(2, '0');

    _numberOfdays = _daysString;
    _numberOfhours = _hoursString;
    _numberOfminutes = _minutesString;
    _numberOfseconds = _secondsString;

    if (otherDate.isBefore(DateTime.now())) {
      _isChallangeTimeDone = true;
    }
  }

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

  Stream<DocumentSnapshot> getChallangeDocument(String challangeId) {
    return _streamServices.getChallangeDocument(challangeId);
  }

  Future addANewShelfByName(
      {String newShelfName,
      String bookId,
      String bookImage,
      String previewLink,
      String title}) async {
    await _cloudFirestoreServices.addANewShelfByName(
        newShelfName: newShelfName,
        bookId: bookId,
        bookImage: bookImage,
        previewLink: previewLink,
        title: title);
  }

  removeChallangeFromMyChallanges() {
    _cloudFirestoreServices.removeChallangeFromMyChallanges(
        challangeId: _challangeId);
  }

  Stream<QuerySnapshot> getUserShelfsStream() async* {
    yield* _cloudFirestoreServices.getUserShelfsStream();
  }

  Stream<QuerySnapshot> getUserBooksInThatShelfStream(
      {@required String shelfName}) async* {
    yield* _cloudFirestoreServices.getUserBooksInThatShelfStream(
        shelfName: shelfName);
  }

  Future addAbooktoSelectedShelf(
      {String shelfId,
      String bookId,
      String bookImage,
      String previewLink,
      String title}) async {
    return await _cloudFirestoreServices.addAbooktoSelectedShelf(
        shelfId: shelfId,
        bookId: bookId,
        bookImage: bookImage,
        previewLink: previewLink,
        title: title);
  }

  bool _isChallangeTimeDone = false;
  bool get isChallangeTimeDone => _isChallangeTimeDone;

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

  Map _trophiesMap;
  Map get trophiesMap => _trophiesMap;

  StreamServices _streamServices = locator<StreamServices>();
  NavigationService _navigationService = locator<NavigationService>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();
}
