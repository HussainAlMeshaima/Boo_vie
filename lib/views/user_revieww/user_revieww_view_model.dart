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
    await _cloudFirestoreServices.addACommentToAReview(
      bookId: _bookId,
      userComment: commentString,
      userImageComment:
          'https://firebasestorage.googleapis.com/v0/b/boovie-22ac7.appspot.com/o/usersImages%2Fhussainxd%40gmail.com%2FuserImage.png?alt=media&token=c1679663-90bc-46ec-b750-fefbc243b5f1',
      userEmailComment: await _authenticationService.userEmail(),
      userNameComment: 'userNameComment',
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

  TextEditingController _commentController = TextEditingController(text: '');
  TextEditingController get commentController => _commentController;
}
