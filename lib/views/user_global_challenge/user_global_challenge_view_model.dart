import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

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
}
