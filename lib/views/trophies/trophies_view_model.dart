import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';

import 'package:boo_vi_app/views/trophy/trophy_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TrophiesViewModel extends BaseViewModel {
  Logger log;

  TrophiesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();
  NavigationService _navigationService = locator<NavigationService>();

  Stream<QuerySnapshot> getUserTrophies() async* {
    yield* _cloudFirestoreServices.getUserTrophies();
  }

  void pushTrophyView({
    @required String docId,
    //--------------------------------------------------------
    @required bool isNormalTrophy,
    @required String trophyChallengeDiscription,
    @required String trophyChallengeImage,
    @required String trophyChallengeName,
    @required List<dynamic> trophyChallengeRules,
    //--------------------------------------------------------
    @required String trophyDescription,
    @required Timestamp trophyReceivedDate,
    @required String trophyTitle,
    //--------------------------------------------------------
    @required String id,
    @required String previewLink,
    @required String title,
  }) {
    _navigationService.navigateWithTransition(
      TrophyView(
        docId: docId,
        //-----------------------------------------------------
        isNormalTrophy: isNormalTrophy,
        trophyChallengeDiscription: trophyChallengeDiscription,
        trophyChallengeImage: trophyChallengeImage,
        trophyChallengeName: trophyChallengeName,
        trophyChallengeRules: trophyChallengeRules,
        //-----------------------------------------------------
        trophyDescription: trophyDescription,
        trophyReceivedDate: trophyReceivedDate,
        trophyTitle: trophyTitle,
        //-----------------------------------------------------
        id: id,
        previewLink: previewLink,
        title: title,
      ),
      transition: 'rightToLeftWithFade',
      duration: Duration(
        milliseconds: 400,
      ),
    );
  }

  handleStartUpLogic() {}
}
