import 'dart:async';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/router_constants.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
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

  Future<QuerySnapshot> getUserShelfsFuture() async {
    return _cloudFirestoreServices.getUserShelfsFuture();
  }

  Stream<QuerySnapshot> getUserBooksInThatShelfStream(
      {@required String shelfName}) async* {
    yield* _cloudFirestoreServices.getUserBooksInThatShelfStream(
        shelfName: shelfName);
  }

  Future<DocumentSnapshot> getUserDetails() async {
    String userEmail = await _authenticationService.userEmail();
    print(userEmail);

    return await _cloudFirestoreServices.getUserDoc(userEmail);
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
      @required String previewLink}) {
    _navigationService.navigateWithTransition(
        BookView(
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

  submitNewSelfNameController(String newString) {
    //return _cloudFirestoreServices.addANewShelfByName(newString);
  }
}
