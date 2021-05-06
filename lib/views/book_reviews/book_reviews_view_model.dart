import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class BookReviewsViewModel extends BaseViewModel {
  Logger log;

  BookReviewsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  Stream getReviewsStream(String bookId) {
    return _cloudFirestoreServices.getReviewsStream(bookId);
  }

  Future<String> getUserId() async {
    String userId = await _authenticationService.userId();

    return userId;
  }

  Future<String> getUserEmail() async {
    return await _authenticationService.userEmail();
  }

  Future addAlikeToABook({String tappedUserEmail}) async {
    await _cloudFirestoreServices.addAlikeToABook(
      bookId: _bookId,
      userEmail: await _authenticationService.userEmail(),
      otherUserReview: tappedUserEmail,
    );
    notifyListeners();
  }

  Future addACommentToABook({String tappedUserEmail}) async {
    await _cloudFirestoreServices.addACommentToAReview(
      bookId: _bookId,
      userComment: _commentController.text,
      userImageComment:
          'https://firebasestorage.googleapis.com/v0/b/boovie-22ac7.appspot.com/o/usersImages%2Fhussainxd%40gmail.com%2FuserImage.png?alt=media&token=c1679663-90bc-46ec-b750-fefbc243b5f1',
      userEmailComment: await _authenticationService.userEmail(),
      userNameComment: 'userNameComment',
      userEmailReview: tappedUserEmail,
    );
    notifyListeners();
  }

  Future<String> getCurrentUserEmail() async {
    return await _authenticationService.userEmail();
  }

  String _bookId;
  handleStartUpLogic(String bookId) {
    _bookId = bookId;
  }

  TextEditingController _commentController = TextEditingController(text: '');
  TextEditingController get commentController => _commentController;
}
