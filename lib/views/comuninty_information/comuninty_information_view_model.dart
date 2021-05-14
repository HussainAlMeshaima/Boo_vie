import 'dart:developer';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/community_challange/community_challange_view.dart';
import 'package:boo_vi_app/views/community_notifications/community_notifications_view.dart';
import 'package:boo_vi_app/views/comunity_active_challenges/comunity_active_challenges_view.dart';
import 'package:boo_vi_app/views/comunity_members/comunity_members_view.dart';
import 'package:boo_vi_app/views/edit_community_rules_and_discription/edit_community_rules_and_discription_view.dart';
import 'package:boo_vi_app/views/room/room_view.dart';
import 'package:boo_vi_app/views/user_review_to_profile/user_review_to_profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ComunintyInformationViewModel extends BaseViewModel {
  Logger log;

  ComunintyInformationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  NavigationService _navigationService = locator<NavigationService>();
  StreamServices _streamServices = locator<StreamServices>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  pushRoom({@required String roomId, @required String doorName}) {
    _navigationService.navigateWithTransition(
        RoomView(
          docId: _docId,
          roomId: roomId,
          doorName: doorName,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  handleStartUpLogic({
    @required String docId,
    @required String communityImage,
    @required String communityAdminImage,
    @required String communityAdminName,
    @required Timestamp communityCreatedon,
    @required String comunityName,
    @required String communityAdminEmail,
    @required String currentUserEmail,
  }) {
    _docId = docId;
    _communityImage = communityImage;
    _communityAdminImage = communityAdminImage;
    _communityAdminName = communityAdminName;
    _communityCreatedon = communityCreatedon;
    _comunityName = comunityName;
    _communityAdminEmail = communityAdminEmail;
    _currentUserEmail = currentUserEmail;
  }

  Stream<QuerySnapshot> getCommunityInformation() {
    return _streamServices.getCommunityInformation(communityId: _docId);
  }

  Stream<QuerySnapshot> getCommunityRooms() {
    return _streamServices.getCommunityRooms(communityId: _docId);
  }

  Stream<QuerySnapshot> getCommunityMembers() {
    return _streamServices.getCommunityMembers(communityId: _docId);
  }

  Stream<QuerySnapshot> getCommunityActiveChallanges() {
    return _streamServices.getCommunityActiveChallanges(communityId: _docId);
  }

  String _docId;
  String get docId => _docId;

  String _currentUserEmail;
  String get currentUserEmail => _currentUserEmail;

  String _communityAdminEmail;
  String get communityAdminEmail => _communityAdminEmail;

  String _comunityName;
  String get comunityName => _comunityName;
  String _communityImage;
  String get communityImage => _communityImage;

  String _communityAdminImage;
  String get communityAdminImage => _communityAdminImage;

  String _communityAdminName;
  String get communityAdminName => _communityAdminName;

  Timestamp _communityCreatedon;
  Timestamp get communityCreatedon => _communityCreatedon;

  void pushUserReviewToProfileAdminView() {
    _navigationService.navigateWithTransition(
        UserReviewToProfileView(
            userEmail: _communityAdminEmail, userImage: _communityAdminImage),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 500));
  }

  void pushUserReviewToProfileView(
      {@required String userEmail, @required String userImage}) {
    _navigationService.navigateWithTransition(
        UserReviewToProfileView(userEmail: userEmail, userImage: userImage),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 500));
  }

  void pushComunityMembersView() {
    _navigationService.navigateWithTransition(
        ComunityMembersView(
          docId: _docId,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 500));
  }

  void pushEditCommunityRulesAndDiscriptionView() {
    _navigationService.navigateWithTransition(
        EditCommunityRulesAndDiscriptionView(
          docId: _docId,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 500));
  }

  void pushCommunityNotificationsView() {
    _navigationService.navigateWithTransition(
        CommunityNotificationsView(
          docId: _docId,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 500));
  }

  void pushCommunityChallangesView({
    @required String challangeType,
    @required String challangeId,
    @required String bookId,
    @required String challengeImage,
    @required String challengeAuthors,
    @required String challengeName,
    @required String previewLink,
    @required String bookTitle,
    @required Timestamp setToDate,
    @required String challengeDiscription,
    @required List challengeRules,
  }) {
    _navigationService.navigateWithTransition(
        CommunityChallangeView(
          challangeId: challangeId,
          bookId: bookId,
          challengeImage: challengeImage,
          challengeAuthors: challengeAuthors,
          challengeName: challengeName,
          previewLink: previewLink,
          bookTitle: bookTitle,
          setToDate: setToDate,
          challengeDiscription: challengeDiscription,
          challengeRules: challengeRules,
          challangeType: challangeType,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  void pushComunityActiveChallengesView() {
    _navigationService.navigateWithTransition(
        ComunityActiveChallengesView(
          docId: _docId,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  sendARequestToAGivenComunityToJoin() async {
    DocumentSnapshot userDoc = await _cloudFirestoreServices.getUserDoc();
    String displayedName = userDoc.get('displayedName');
    String userEmail = userDoc.get('userEmail');
    String userImage = userDoc.get('userImage');

    _cloudFirestoreServices.sendARequestToAGivenComunityToJoin(
      displayedName: displayedName,
      docId: _docId,
      memberEmail: userEmail,
      userImage: userImage,
    );
  }
}
