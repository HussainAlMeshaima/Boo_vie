import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/views/compleated_challange/compleated_challange_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class CompletedChallengesViewModel extends BaseViewModel {
  Logger log;

  CompletedChallengesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  Stream<QuerySnapshot> getCompletedChallengesStream() async* {
    yield* _cloudFirestoreServices.getCompletedChallengesStream();
  }

  NavigationService _navigationService = locator<NavigationService>();
  void compleatedChallangeView({
    @required String bookId,
    @required String bookTitle,
    @required String challengeAuthorName,
    @required String challengeDiscription,
    @required String challengeImage,
    @required String previewLink,
    @required List<dynamic> challengeRules,
    @required Timestamp completedDate,
    @required String challengeId,
  }) async {
    _navigationService.navigateWithTransition(
        CompleatedChallangeView(
          challengeId: challengeId,
          bookId: bookId,
          bookTitle: bookTitle,
          challengeAuthorName: challengeAuthorName,
          challengeDiscription: challengeDiscription,
          challengeImage: challengeImage,
          completedDate: completedDate,
          challengeRules: challengeRules,
          previewLink: previewLink,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 500));
  }
}
