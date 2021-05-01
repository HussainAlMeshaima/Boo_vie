import 'dart:async';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/router_constants.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';

import 'package:boo_vi_app/views/profile_to_edit_details/profile_to_edit_details_view.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  Logger log;

  ProfileViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();

  pushProfileToEditDetailsView({String userImage}) {
    return _navigationService.navigateWithTransition(
        ProfileToEditDetailsView(
          userImage: userImage,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  Future signOut(context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(await _authenticationService.signOut()),
      ),
    );

    Timer(Duration(seconds: 4, milliseconds: 520), () async {
      _navigationService.pushNamedAndRemoveUntil(loginViewRoute);
    });
  }

  Stream<QuerySnapshot> getUserShelfsStream() async* {
    yield* _cloudFirestoreServices.getUserShelfsStream();
  }

  Stream<QuerySnapshot> getUserBooksInThatShelfStream(
      {@required String shelfName}) async* {
    yield* _cloudFirestoreServices.getUserBooksInThatShelfStream(
        shelfName: shelfName);
  }

  Future<DocumentSnapshot> getUserInformationDoc() async {
    return await _cloudFirestoreServices.getUserInformationDoc();
  }

  Future<DocumentSnapshot> getUserInformation() {
    return _cloudFirestoreServices.getUserInformation();
  }

  TextEditingController _displayedNameController =
      TextEditingController(text: '');
  TextEditingController get displayedNameController => _displayedNameController;

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

  TextEditingController _newSelfNameController =
      TextEditingController(text: '');
  TextEditingController get newSelfNameController => _newSelfNameController;
}
