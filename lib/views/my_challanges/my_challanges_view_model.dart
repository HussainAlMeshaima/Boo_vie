import 'dart:async';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class MyChallangesViewModel extends BaseViewModel {
  Logger log;

  MyChallangesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  NavigationService _navigationService = locator<NavigationService>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  String _authors;
  String get authors => _authors;

  String _bookImage;
  String get bookImage => _bookImage;

  String _id;
  String get id => _id;

  bool _isCompleated;
  bool get isCompleated => _isCompleated;

  String _previewLink;
  String get previewLink => _previewLink;

  Timestamp _setToDate;
  Timestamp get setToDate => _setToDate;

  String _title;
  String get title => _title;

  String _numberOfdays;
  String get numberOfdays => _numberOfdays;

  String _numberOfhours;
  String get numberOfhours => _numberOfhours;

  String _numberOfminutes;
  String get numberOfminutes => _numberOfminutes;

  String _numberOfseconds;
  String get numberOfseconds => _numberOfseconds;

  bool _challangeTimeIsNotDone = false;
  bool get challangeTimeIsNotDone => _challangeTimeIsNotDone;

  bool _challangeHasNotBeenCompleated;
  bool get challangeHasNotBeenCompleated => _challangeHasNotBeenCompleated;

  bool _showMarkAsDoneButton = true;
  bool get showMarkAsDoneButton => _showMarkAsDoneButton;

  Stream<DocumentSnapshot> getUserMyChallangeSetToDateStream() async* {
    yield* _cloudFirestoreServices.getUserMyChallangeSetToDateStream(
        bookId: _id);
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
          authors: _authors,
          id: _id,
          image: _bookImage,
          text: _title,
          previewLink: _previewLink,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  handleStartUpLogic(
      {String title,
      String id,
      String authors,
      String bookImage,
      bool isCompleated,
      String previewLink,
      Timestamp setToDate}) {
    _title = title;
    _id = id;
    _authors = authors;
    _bookImage = bookImage;
    _isCompleated = isCompleated;
    _previewLink = previewLink;
    _setToDate = setToDate;
    _challangeHasNotBeenCompleated = isCompleated;
    convertTheGivenTimestampToString();
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

    notifyListeners();
  }

  Future<void> markMyChallangeAsCompleated(
      {@required BuildContext context}) async {
    await _cloudFirestoreServices.markMyChallangeAsCompleated(bookId: _id);
    _challangeHasNotBeenCompleated = !_challangeHasNotBeenCompleated;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Challange compleated !')));

    notifyListeners();
  }

  Future<void> removeChallangeFromMyChallange(
      {@required BuildContext context}) async {
    await _cloudFirestoreServices.removeChallangeFromMyChallange(bookId: _id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1), content: Text('Challange removed !')));
  }
}
