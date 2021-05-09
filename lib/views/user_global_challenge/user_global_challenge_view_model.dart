import 'dart:async';
import 'dart:ui';

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

class UserGlobalChallengeViewModel extends BaseViewModel {
  Logger log;

  UserGlobalChallengeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  handleStartUpLogic(
      {@required String challangeId,
      @required String bookId,
      @required String challengeImage,
      @required bool compleatedChallenge,
      @required String challengeAuthors,
      @required String challengeName,
      @required String previewLink,
      @required String bookTitle,
      @required Timestamp setToDate,
      @required String challengeDiscription,
      @required Map trophiesMap,
      @required List challengeRules}) {
    _isBusy = true;
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
    _setToDate = setToDate;
    _challangeHasNotBeenCompleated = compleatedChallenge;

    convertTheGivenTimestampToString();

    if (_challangeHasNotBeenCompleated || _challangeTimeIsNotDone) {
      _showMarkAsDoneButton = false;
    } else {
      Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) {
          if (!_challangeHasNotBeenCompleated && !_challangeTimeIsNotDone) {
            convertTheGivenTimestampToString();
          } else {
            _showMarkAsDoneButton = false;
            timer.cancel();
          }
          notifyListeners();
        },
      );
    }
    _isBusy = false;
    notifyListeners();
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
      _challangeTimeIsNotDone = true;
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
      {@required String newShelfName,
      @required String bookId,
      @required String authors,
      @required String bookImage,
      @required String previewLink,
      @required String title}) async {
    await _cloudFirestoreServices.addANewShelfByName(
        authors: authors,
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

  // Stream<QuerySnapshot> getUserShelfsStream() async* {
  //   yield* _cloudFirestoreServices.getUserShelfsStream();
  // }

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

  bool _challangeTimeIsNotDone = false;
  bool get challangeTimeIsNotDone => _challangeTimeIsNotDone;

  bool _challangeHasNotBeenCompleated;
  bool get challangeHasNotBeenCompleated => _challangeHasNotBeenCompleated;

  bool _showMarkAsDoneButton = true;
  bool get showMarkAsDoneButton => _showMarkAsDoneButton;

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

  markThatBookAsDone(BuildContext context) async {
    await _cloudFirestoreServices.markThatBookChallangeAsDone(
      previewLink: _previewLink,
      bookId: bookId,
      bookTitle: bookTitle,
      challengeAuthorName: _challengeAuthors,
      challengeId: _challangeId,
      challengeDiscription: _challengeDiscription,
      trophyMap: _trophiesMap,
      challengeImage: _challengeImage,
      challengeName: _challengeName,
      challengeRules: _challengeRules,
    );
    _challangeHasNotBeenCompleated = true;
    _showMarkAsDoneButton = false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Challange compleated! New trophy added!'),
      ),
    );
  }

  Widget whichWigetToShowHabibi(context) {
    if (_challangeHasNotBeenCompleated) {
      return Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Tooltip(
            message: 'Challenge Compleated 😊',
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: NetworkImage(
                        image,
                      ),
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10, sigmaY: 10, tileMode: TileMode.clamp),
                    child: Container(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.green.withOpacity(0.5)
                          : Colors.green.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Center(
                          child: Text(
                            'Challenge Compleated 😊',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else if (_challangeTimeIsNotDone) {
      return Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.dstATop),
                    image: NetworkImage(
                      image,
                    ),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 10, sigmaY: 10, tileMode: TileMode.clamp),
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.red.withOpacity(0.5)
                        : Colors.red.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Center(
                        child: Text(
                          'Challenge dismissed 😭',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    notifyListeners();
    return Container(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: NetworkImage(
                    image,
                  ),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 10, sigmaY: 10, tileMode: TileMode.clamp),
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.5)
                      : Colors.white.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              numberOfdays.toString(),
                              style: TextStyle(fontSize: 26),
                            ),
                            Text(
                              'DAYS',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color
                                      .withOpacity(.35)),
                            ),
                          ],
                        ),
                        Text(
                          ':',
                          style: TextStyle(
                              fontSize: 26,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .color
                                  .withOpacity(.7)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              numberOfhours.toString(),
                              style: TextStyle(fontSize: 26),
                            ),
                            Text(
                              'HOUR',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color
                                      .withOpacity(.35)),
                            ),
                          ],
                        ),
                        Text(
                          ':',
                          style: TextStyle(
                              fontSize: 26,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .color
                                  .withOpacity(.7)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              numberOfminutes.toString(),
                              style: TextStyle(fontSize: 26),
                            ),
                            Text(
                              'MIN',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color
                                      .withOpacity(.35)),
                            ),
                          ],
                        ),
                        Text(
                          ':',
                          style: TextStyle(
                              fontSize: 26,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .color
                                  .withOpacity(.7)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              numberOfseconds.toString(),
                              style: TextStyle(fontSize: 26),
                            ),
                            Text(
                              'SEC',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color
                                      .withOpacity(.35)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
