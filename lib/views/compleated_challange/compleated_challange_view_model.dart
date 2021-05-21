import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:boo_vi_app/views/user_review_to_profile/user_review_to_profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class CompleatedChallangeViewModel extends BaseViewModel {
  Logger log;

  CompleatedChallangeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  StreamServices _streamServices = locator<StreamServices>();

  void pushBookView() {
    _navigationService.navigateWithTransition(
        BookView(
          authors: _bookAuthors,
          id: _bookId,
          image: _challengeImage,
          text: _bookTitle,
          previewLink: _previewLink,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  String _bookId;
  String get bookId => _bookId;

  String _bookAuthors;
  String get bookAuthors => _bookAuthors;

  String _challengeAuthorName;
  String get challengeAuthorName => _challengeAuthorName;

  String _challengeImage;
  String get challengeImage => _challengeImage;

  String _challengeId;
  String get challengeId => _challengeId;

  String _challengeName;
  String get challengeName => _challengeName;

  String _previewLink;
  String get previewLink => _previewLink;

  String _bookTitle;
  String get bookTitle => _bookTitle;

  String _challengeDiscription;
  String get challengeDiscription => _challengeDiscription;

  List<dynamic> _challengeRules;
  List<dynamic> get challengeRules => _challengeRules;

  Timestamp _completedDate;
  Timestamp get completedDate => _completedDate;

  handleStartUpLogic({
    String bookId,
    String bookTitle,
    String challengeAuthorName,
    String challengeDiscription,
    String challengeImage,
    List challengeRules,
    Timestamp completedDate,
    String previewLink,
    String challengeId,
  }) {
    _bookId = bookId;
    _bookTitle = bookTitle;
    _challengeAuthorName = challengeAuthorName;
    _challengeDiscription = challengeDiscription;
    _challengeImage = challengeImage;
    _challengeRules = challengeRules;
    _completedDate = completedDate;
    _previewLink = previewLink;
    _challengeId = challengeId;
  }

  Future<void> pushUserReviewToProfileCommentView({
    @required String userImageComment,
    @required String userEmailComment,
  }) async {
    _navigationService.navigateWithTransition(
        UserReviewToProfileView(
            userEmail: userEmailComment, userImage: userImageComment),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 500));
  }

  Stream<QuerySnapshot> getChallangeComments() {
    return _streamServices.getChallangeComments(_challengeId);
  }
}
