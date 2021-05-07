import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TrophyViewModel extends BaseViewModel {
  Logger log;

  TrophyViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  NavigationService _navigationService = locator<NavigationService>();
  pushBookView(
      {@required String id,
      @required String image,
      @required String bookTitle,
      @required String previewLink,
      @required String authors}) {
    _navigationService.navigateWithTransition(
        // ignore: missing_required_param
        BookView(
          id: id,
          image: image,
          previewLink: previewLink,
          text: _title,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  handleStartUpLogic({
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
    @required String id,
    @required String previewLink,
    @required String title,
  }) {
    _docId = docId;
    //--------------------------------------------------------
    _isNormalTrophy = isNormalTrophy;
    _trophyChallengeDiscription = trophyChallengeDiscription;
    _trophyChallengeImage = trophyChallengeImage;
    _trophyChallengeName = trophyChallengeName;
    _trophyChallengeRules = trophyChallengeRules;
    //--------------------------------------------------------
    _trophyDescription = trophyDescription;
    _trophyReceivedDate = trophyReceivedDate;
    _trophyTitle = trophyTitle;
    _id = id;
    _previewLink = previewLink;
    _title = title;
  }

  String _docId;
  String get docId => _docId;

  String _previewLink;
  String get previewLink => _previewLink;

  String _id;
  String get id => _id;

  String _title;
  String get title => _title;

  bool _isNormalTrophy;
  bool get isNormalTrophy => _isNormalTrophy;

  String _trophyChallengeAuthorName;
  String get trophyChallengeAuthorName => _trophyChallengeAuthorName;

  String _trophyChallengeDiscription;
  String get trophyChallengeDiscription => _trophyChallengeDiscription;

  String _trophyChallengeImage;
  String get trophyChallengeImage => _trophyChallengeImage;

  String _trophyChallengeName;
  String get trophyChallengeName => _trophyChallengeName;

  List<dynamic> _trophyChallengeRules;
  List<dynamic> get trophyChallengeRules => _trophyChallengeRules;

  String _trophyDescription;
  String get trophyDescription => _trophyDescription;

  Timestamp _trophyReceivedDate;
  Timestamp get trophyReceivedDate => _trophyReceivedDate;

  String _trophyTitle;
  String get trophyTitle => _trophyTitle;
}
