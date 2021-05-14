import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/room/room_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:boo_vi_app/views/comuninty_information/comuninty_information_view.dart';

class ComunintysViewModel extends BaseViewModel {
  Logger log;

  ComunintysViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  StreamServices _streamServices = locator<StreamServices>();

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  handleSwipIndexChanged(int swipdIndex) {
    if (swipdIndex != _pageIndex) _pageIndex = swipdIndex;
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 450), curve: Curves.easeOutSine);

    notifyListeners();
  }

  handleTapIndexChanged(int tapedIndex) {
    if (tapedIndex != _pageIndex) _pageIndex = tapedIndex;
    pageController.jumpToPage(pageIndex);

    notifyListeners();
  }

  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  pushComunintyInformationView({
    @required String docId,
    @required String comunityName,
    @required String communityImage,
    @required String communityAdminName,
    @required Timestamp communityCreatedon,
    @required String communityAdminImage,
    @required String communityAdminEmail,
  }) async {
    print('-----------------------------');
    print(communityAdminEmail);
    print('-----------------------------');
    print(await _authenticationService.userEmail());
    print('-----------------------------');
    return _navigationService.navigateWithTransition(
        ComunintyInformationView(
          docId: docId,
          communityAdminImage: communityAdminImage,
          communityAdminName: communityAdminName,
          communityCreatedon: communityCreatedon,
          communityImage: communityImage,
          comunityName: comunityName,
          communityAdminEmail: communityAdminEmail,
          currentUserEmail: await _authenticationService.userEmail(),
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  // void pushRoomView({@required String otherUser}) {
  //   _navigationService.navigateWithTransition(RoomView(),
  //       transition: 'rightToLeftWithFade',
  //       duration: Duration(milliseconds: 400));
  // }

  Stream<QuerySnapshot> getCommunities() {
    return _streamServices.getCommunities();
  }

  String _currentUserEmail;
  String get currentUserEmail => _currentUserEmail;
}
