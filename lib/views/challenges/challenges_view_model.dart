import 'dart:async';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/global_challenge/global_challenge_view.dart';
import 'package:boo_vi_app/views/user_global_challenge/user_global_challenge_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  pushBookReviews({String bookId, String tappedUserEmail}) async {}

  handleStartUpLogic() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      notifyListeners();
    });
  }

  Stream<QuerySnapshot> getThatBookEmoji(String bookId) {
    return _cloudFirestoreServices.getBookRatingEmoji(bookId);
  }
}
