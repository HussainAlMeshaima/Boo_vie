import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/user_review_to_profile/user_review_to_profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ComunityMembersViewModel extends BaseViewModel {
  Logger log;

  ComunityMembersViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  NavigationService _navigationService = locator<NavigationService>();
  StreamServices _streamServices = locator<StreamServices>();

  Stream<QuerySnapshot> getFullCommunityMembers() async* {
    yield* _streamServices.getFullCommunityMembers(communityId: _docId);
  }

  String _docId;
  String get docId => _docId;

  handleStartUpLogic({@required String docId}) {
    _docId = docId;
  }

  void pushUserReviewToProfileView(
      {@required String userEmail, @required String userImage}) {
    _navigationService.navigateWithTransition(
        UserReviewToProfileView(userEmail: userEmail, userImage: userImage),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 500));
  }
}
