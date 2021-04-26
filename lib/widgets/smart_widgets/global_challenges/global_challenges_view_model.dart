import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/views/global_challenge/global_challenge_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class GlobalChallengesViewModel extends BaseViewModel {
  Logger log;

  GlobalChallengesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();

  pushGlobalChallengeView(
      {@required String bookId,
      @required String bookTitle,
      @required String bookImage,
      @required String challengeTitle,
      @required String challengeDisc,
      @required DateTime challengeDate,
      @required int numberOfPeopleWhoHasCompletedThatChallenge,
      @required int numberOfPeopleWhoHasNotCompletedThatChallenge,
      @required String trophyName,
      @required String trophyImage,
      @required String trophyIcon,
      @required String trophyDisc,
      @required int trophyCount,
      @required int arrowUpCount,
      @required int arrowDownCount,
      @required bookAuthor}) {
    _navigationService.navigateWithTransition(
        GlobalChallengeView(
          bookId: bookId,
          bookTitle: bookTitle,
          bookImage: bookImage,
          challengeTitle: challengeTitle,
          challengeDisc: challengeDisc,
          challengeDate: challengeDate,
          numberOfPeopleWhoHasCompletedThatChallenge:
              numberOfPeopleWhoHasCompletedThatChallenge,
          numberOfPeopleWhoHasNotCompletedThatChallenge:
              numberOfPeopleWhoHasNotCompletedThatChallenge,
          trophyName: trophyName,
          trophyImage: trophyImage,
          trophyIcon: trophyIcon,
          trophyCount: trophyCount,
          trophyDisc: trophyDisc,
          arrowDownCount: arrowDownCount,
          arrowUpCount: arrowUpCount,
          bookAuthor: bookAuthor,
        ),
        transition: 'rightToLeftWithFade');
  }
}
