import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class UserReviewwViewModel extends BaseViewModel {
  Logger log;

  UserReviewwViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  Stream<DocumentSnapshot> getUserReviewsStream({
    @required String bookId,
    @required String tappedUserEmail,
  }) {
    return _cloudFirestoreServices.getUserReviewsStream(
        bookId, tappedUserEmail);
  }

  Future addAlikeToABook({String tappedUserEmail}) async {
    await _cloudFirestoreServices.addAlikeToABook(
      bookId: _bookId,
      userEmail: await _authenticationService.userEmail(),
      otherUserReview: tappedUserEmail,
    );
    print(tappedUserEmail);
    notifyListeners();
  }

  Future addACommentToABook(
      {String commentString, String tappedUserEmail}) async {
    var userDoc = await _cloudFirestoreServices
        .getUserDoc(await _authenticationService.userEmail());
    await _cloudFirestoreServices.addACommentToAReview(
      bookId: _bookId,
      userComment: commentString,
      userImageComment: userDoc['userImage'],
      userEmailComment: await _authenticationService.userEmail(),
      userNameComment: userDoc['displayedName'],
      userEmailReview: _tappedUserEmail,
    );
    notifyListeners();
  }

  String _bookId;
  String _tappedUserEmail;
  handleStartUpLogic({String bookId, String tappedUserEmail}) {
    _bookId = bookId;
    _tappedUserEmail = tappedUserEmail;
  }

  Future<DocumentSnapshot> getLikeBoolValue(
    String bookId,
  ) async {
    DocumentSnapshot value = await _cloudFirestoreServices.getLikeBoolValue(
        bookId: bookId, tappedUserEmail: _tappedUserEmail);
    notifyListeners();
    return value;
  }

  Stream<QuerySnapshot> getReviewComments() {
    return _cloudFirestoreServices.getReviewComments(
        bookId: _bookId, tappedUserEmail: _tappedUserEmail);
  }

  Future<String> getUserEmail() async {
    return await _authenticationService.userEmail();
  }

  TextEditingController _commentController = TextEditingController(text: '');
  TextEditingController get commentController => _commentController;
}
