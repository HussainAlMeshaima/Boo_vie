import 'dart:async';
import 'dart:core';
import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class GlobalChallengeViewModel extends BaseViewModel {
  Logger log;

  GlobalChallengeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  handleStartUpLogic({
    @required String bookTitle,
    @required String bookId,
    @required String previewLink,
    //-----------------------------------------------------------
    @required String challangeId,
    @required String challengeName,
    @required String challengeImage,
    @required String challengeAuthors,
    @required String challengeDiscription,
    @required int challengeLikeCounter,
    @required List challengeRules,
    //-----------------------------------------------------------
    @required int numberOfCommentsCount,
    @required int numberOfCommunitiesWhoHasThatChallangeCount,
    //-----------------------------------------------------------
    @required int trophiesCount,
    @required Map trophiesMap,
    //-----------------------------------------------------------
    @required Timestamp setToDate,
  }) {
    _bookTitle = bookTitle;
    _bookId = bookId;
    _previewLink = previewLink;
    //-----------------------------------------------------------
    _challangeId = challangeId;
    _challengeName = challengeName;
    _challengeImage = challengeImage;
    _challengeAuthors = challengeAuthors;
    _challengeDiscription = challengeDiscription;
    _challengeLikeCounter = challengeLikeCounter;
    _challengeRules = challengeRules;
    //-----------------------------------------------------------
    _numberOfCommentsCount = numberOfCommentsCount;
    _numberOfCommunitiesWhoHasThatChallangeCount =
        numberOfCommunitiesWhoHasThatChallangeCount;
    //-----------------------------------------------------------
    _trophiesCount = trophiesCount;
    _trophiesMap = trophiesMap;
    //-----------------------------------------------------------
    _setToDate = setToDate;

    convertTheGivenTimestampToString();

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      convertTheGivenTimestampToString();

      notifyListeners();
    });
  }

  StreamServices _streamServices = locator<StreamServices>();
  NavigationService _navigationService = locator<NavigationService>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  Stream<DocumentSnapshot> getChallangeDocument(String challangeId) {
    return _streamServices.getChallangeDocument(challangeId);
  }

  Stream<QuerySnapshot> getChallangeComments(String challangeId) {
    return _streamServices.getChallangeComments(challangeId);
  }

  void pushBookView() {
    _navigationService.navigateWithTransition(
        BookView(
          authors: _bookAuthors,
          id: _bookId,
          image: _challengeImage,
          text: _bookTitle,
          previewLink: _previewLink,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
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
  }

  Stream<QuerySnapshot> getUserBooksInThatShelfStream(
      {@required String shelfName}) async* {
    yield* _cloudFirestoreServices.getUserBooksInThatShelfStream(
        shelfName: shelfName);
  }

  Stream<DocumentSnapshot> getGlobalChallengeStream() {
    return _streamServices.getGlobalChallengeStream(_challangeId);
  }

  Stream<QuerySnapshot> getUserShelfsStream() async* {
    yield* _cloudFirestoreServices.getUserShelfsStream();
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

  Future addACommentToAGlobalChallange() async {
    DocumentSnapshot userDoc = await _cloudFirestoreServices.getUserDoc();
    await _cloudFirestoreServices.addACommentToAGlobalChallange(
      userImageComment: userDoc['userImage'],
      userNameComment: userDoc['displayedName'],
      bookId: _bookId,
      challangeId: _challangeId,
      userComment: _commentController.text,
    );
  }

  Future addTheSelectedChallangeToMyChallanges() {
    return _cloudFirestoreServices.addTheSelectedChallangeToMyChallanges(
        challangeId: _challangeId,
        challengeAuthors: _challengeAuthors,
        challengeImage: _challengeImage,
        challengeDiscription: _challengeDiscription,
        setToDate: _setToDate,
        bookId: _bookId,
        trophiesCount: _trophiesCount,
        challengeName: _challengeName,
        bookTitle: _bookTitle,
        challengeRules: _challengeRules,
        trophiesMap: _trophiesMap,
        previewLink: _previewLink,
        numberOfCommentsCount: _numberOfCommentsCount,
        numberOfCommunitiesWhoHasThatChallangeCount:
            _numberOfCommunitiesWhoHasThatChallangeCount,
        challengeLikeCounter: _challengeLikeCounter);
  }

  TextEditingController _commentController = TextEditingController(text: '');
  TextEditingController get commentController => _commentController;

  String _challangeId;
  String get challangeId => _challangeId;

  String _bookId;
  String get bookId => _bookId;

  String _bookAuthors;
  String get bookAuthors => _bookAuthors;

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

  int _challengeLikeCounter;
  int get challengeLikeCounter => _challengeLikeCounter;

  int _numberOfCommentsCount;
  int get numberOfCommentsCount => _numberOfCommentsCount;

  int _numberOfCommunitiesWhoHasThatChallangeCount;
  int get numberOfCommunitiesWhoHasThatChallangeCount =>
      _numberOfCommunitiesWhoHasThatChallangeCount;

  Map _trophiesMap;
  Map get trophiesMap => _trophiesMap;

  int _trophiesCount;
  int get trophiesCount => _trophiesCount;
}
