import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ComunitySheetViewModel extends BaseViewModel {
  Logger log;

  ComunitySheetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<QuerySnapshot> allCreatedComunities() {
    return _cloudFirestoreServices.allCreatedComunities();
  }

  handleStartUpLogic({
    @required String bookId,
    @required String bookTitle,
    @required String challengeAuthors,
    @required String challengeDiscription,
    @required String challengeImage,
    @required String challengeName,
    @required String previewLink,
  }) async {
    _userEmail = await _authenticationService.userEmail();
  }

  String _userEmail;
  String get userEmail => _userEmail;

  void setBookAsAChallangeToThatComunity({String docId}) {}
}
