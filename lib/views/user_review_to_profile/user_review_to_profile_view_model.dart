import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class UserReviewToProfileViewModel extends BaseViewModel {
  Logger log;

  UserReviewToProfileViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  handleStartUpLogic({String userEmail, String userImage}) {
    _userEmail = userEmail;
    _userImage = userImage;
  }

  Stream<QuerySnapshot> getOtherUserBooksInThatShelfStream(
      {@required String shelfName}) async* {
    yield* _cloudFirestoreServices.getOtherUserBooksInThatShelfStream(
        shelfName: shelfName, otherUserEmail: _userEmail);
  }

  Stream<QuerySnapshot> getOtherUserShelfsStream() async* {
    yield* _cloudFirestoreServices.getOtherUserShelfsStream(
        otherUserEmail: _userEmail);
  }

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

  String _userEmail;
  String get userEmail => _userEmail;

  String _userImage;
  String get userImage => _userImage;
}
