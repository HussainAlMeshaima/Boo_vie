import 'dart:async';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:boo_vi_app/views/completed_challenges/completed_challenges_view.dart';
import 'package:boo_vi_app/views/global_challenge/global_challenge_view.dart';
import 'package:boo_vi_app/views/my_challanges/my_challanges_view.dart';
import 'package:boo_vi_app/views/trophies/trophies_view.dart';
import 'package:boo_vi_app/views/user_global_challenge/user_global_challenge_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ChallengesViewModel extends BaseViewModel {
  Logger log;

  ChallengesViewModel() {
    log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  StreamServices _streamServices = locator<StreamServices>();

  Future<DocumentSnapshot> getUserChallenges() {
    return _cloudFirestoreServices.getUserChallenges();
  }

  Stream<QuerySnapshot> getUserGlobalChallengesStream() {
    return _cloudFirestoreServices.getUserGlobalChallengesStream();
  }

  Stream<QuerySnapshot> getMyChallengesStream() {
    return _cloudFirestoreServices.getMyChallengesStream();
  }

  Stream<QuerySnapshot> getGlobalChallengesStream() {
    return _streamServices.getGlobalChallengesStream();
  }

  NavigationService _navigationService = locator<NavigationService>();

  void pushGlobalChallengeView({
    @required String image,
    @required String challangeId,
    @required String bookId,
    @required String previewLink,
    @required String bookTitle,
    @required String challengeName,
    @required String challengeAuthors,
    @required Timestamp setToDate,
    @required int challengeLikeCounter,
    @required int numberOfPeopleWhoHasTheChallengeCount,
    @required int trophiesCount,
    @required int numberOfCommentsCount,
    @required int numberOfCommunitiesWhoHasThatChallangeCount,
    @required String challengeDiscription,
    @required List challengeRules,
    @required Map trophiesMap,
  }) {
    _navigationService.navigateWithTransition(
        GlobalChallengeView(
          image: image,
          challangeId: challangeId,
          bookId: bookId,
          previewLink: previewLink,
          bookTitle: bookTitle,
          challengeName: challengeName,
          challengeAuthors: challengeAuthors,
          challengeLikeCounter: challengeLikeCounter,
          setToDate: setToDate,
          numberOfPeopleWhoHasTheChallengeCount:
              numberOfPeopleWhoHasTheChallengeCount,
          trophiesCount: trophiesCount,
          challengeDiscription: challengeDiscription,
          numberOfCommentsCount: numberOfCommentsCount,
          numberOfCommunitiesWhoHasThatChallangeCount:
              numberOfCommunitiesWhoHasThatChallangeCount,
          challengeRules: challengeRules,
          trophiesMap: trophiesMap,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  void pushUserGlobalChallengeView({
    @required String image,
    @required String challangeId,
    @required String bookId,
    @required String previewLink,
    @required String bookTitle,
    @required String challengeName,
    @required String challengeAuthors,
    @required Timestamp setToDate,
    @required int challengeLikeCounter,
    @required int numberOfPeopleWhoHasTheChallengeCount,
    @required int trophiesCount,
    @required int numberOfCommentsCount,
    @required int numberOfCommunitiesWhoHasThatChallangeCount,
    @required String challengeDiscription,
    @required List challengeRules,
    @required Map trophiesMap,
    @required bool compleatedChallenge,
  }) {
    _navigationService.navigateWithTransition(
        UserGlobalChallengeView(
          challengeimage: image,
          challangeId: challangeId,
          bookId: bookId,
          previewLink: previewLink,
          bookTitle: bookTitle,
          challengeName: challengeName,
          challengeAuthors: challengeAuthors,
          setToDate: setToDate,
          challengeDiscription: challengeDiscription,
          challengeRules: challengeRules,
          trophiesMap: trophiesMap,
          compleatedChallenge: compleatedChallenge,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
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

  pushTrophiesView() {
    _navigationService.navigateWithTransition(TrophiesView(),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  pushBookReviews({String bookId, String tappedUserEmail}) async {}

  handleStartUpLogic() {
    Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        notifyListeners();
      },
    );
  }

  Stream<QuerySnapshot> getThatBookEmoji(String bookId) {
    return _cloudFirestoreServices.getBookRatingEmoji(bookId);
  }

  Timestamp _setToDate;
  Timestamp get setToDate => _setToDate;

  String _numberOfhours;
  String get numberOfhours => _numberOfhours;

  String _numberOfminutes;
  String get numberOfminutes => _numberOfminutes;

  String _numberOfseconds;
  String get numberOfseconds => _numberOfseconds;

  String convertTheGivenTimestampToString(Timestamp setToDate) {
    DateTime otherDate = setToDate.toDate();

    Duration date = otherDate.difference(DateTime.now());

    int _days = date.inDays;
    int _hours = date.inHours % 24;
    int _minutes = date.inMinutes % 60;
    int _seconds = date.inSeconds % 60;

    String _daysString = '$_days';
    String _hoursString = '$_hours'.padLeft(2, '0');
    String _minutesString = '$_minutes'.padLeft(2, '0');
    String _secondsString = '$_seconds'.padLeft(2, '0');

    _daysString = _daysString;
    _numberOfhours = _hoursString;
    _numberOfminutes = _minutesString;
    _numberOfseconds = _secondsString;

    return (_numberOfhours.toString() +
        ' : ' +
        _numberOfminutes.toString() +
        ' : ' +
        _numberOfseconds.toString());
  }

  bool _hasGlobalChallenges = true;
  bool get hasGlobalChallenges => _hasGlobalChallenges;

  bool _hasMyChallenges = true;
  bool get hasMyChallenges => _hasMyChallenges;

  pushMyChallangesView(
      {@required String title,
      @required String id,
      @required String authors,
      @required String bookImage,
      @required bool isCompleated,
      @required String previewLink,
      @required Timestamp setToDate}) {
    _navigationService.navigateWithTransition(
        MyChallangesView(
          title: title,
          id: id,
          authors: authors,
          bookImage: bookImage,
          isCompleated: isCompleated,
          previewLink: previewLink,
          setToDate: setToDate,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  pushCompletedChallengesView() {
    _navigationService.navigateWithTransition(CompletedChallengesView(),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  void sethasGlobalChallengesToTrue() {
    _hasGlobalChallenges = true;
  }

  void setHasMyChallengesToTrue() {
    _hasMyChallenges = true;
  }

  TabController _tabController;
  TabController get tabController => _tabController;

  ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  Color whatColorIsThatChallange(
      {@required bool challengeIsCompleated, @required int setToDate}) {
    if (challengeIsCompleated) {
      return Colors.green;
    }
    if (setToDate <= 0) {
      return Colors.red.withOpacity(.7);
    }

    return Colors.black54;
  }

  Color whatColorToShowHabibi(
      {@required bool isCompleated, @required Timestamp setToDate}) {
    DateTime thatDate = setToDate.toDate();
    if (isCompleated) {
      return Colors.green;
    }
    if (thatDate.isBefore(DateTime.now())) {
      return Colors.red;
    }
  }

  Widget whichContainerToShowHabibi({
    @required bool isCompleated,
    @required Timestamp setToDate,
    @required BuildContext context,
  }) {
    DateTime thatDate = setToDate.toDate();
    if (isCompleated) {
      return Container(
        height: 47,
        width: 155,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(7)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Compleated',
                style: TextStyle(
                    fontSize: 20, wordSpacing: 5, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    } else if (thatDate.isBefore(DateTime.now())) {
      return Container(
        height: 47,
        width: 155,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(7)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dismissed',
                style: TextStyle(
                    fontSize: 20, wordSpacing: 5, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 47,
        width: 155,
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Color(0xff262626)
                : Color(0xffE8E8E8),
            borderRadius: BorderRadius.circular(7)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                convertTheGivenTimestampToString(setToDate),
                style: TextStyle(
                    fontSize: 20, wordSpacing: 5, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    }
  }
}
