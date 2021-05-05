import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class BookReviewSheetViewModel extends BaseViewModel {
  Logger log;

  BookReviewSheetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  String _bookId;
  String _bookImage;
  String _authors;
  String get authors => _authors;
  String _bookTitle;
  String _bookpreviewLink;
  bool _spoiler = false;

  bool get spoiler => _spoiler;

  handleStartUpLogic({
    @required String bookId,
    @required String bookImage,
    @required String bookTitle,
    @required String bookpreviewLink,
    @required String authors,
  }) {
    _bookId = bookId;
    _bookImage = bookImage;
    _authors = authors;
    _bookTitle = bookTitle;
    _bookpreviewLink = bookpreviewLink;
  }

  void toggleSpoiler(bool value) {
    _spoiler = value;
    notifyListeners();
  }

  double _newSliderValue = 0;
  double get newSliderValue => _newSliderValue;
  List _emojis = [
    '😡',
    '🤢',
    '😟',
    '😧',
    '😨',
    '😰',
    '😓',
    '😫',
    '😭',
    '😦',
    '😮',
    '😃',
    '😁',
    '🥰',
    '😍',
  ];
  List get emojis => _emojis;

  updateSliderOriginalValue(double newValue) {
    _newSliderValue = newValue;
    notifyListeners();
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  submitAReview(BuildContext context) async {
    Navigator.pop(context);

    if (reviewController.text == '') {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Please include a review to be recorded')));
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Reviews has been updated')));
    String userEmail = await _authenticationService.userEmail();
    String userId = await _authenticationService.userId();
    DocumentSnapshot userDoc =
        await _cloudFirestoreServices.getUserCollection(userEmail);

    String displayedName = userDoc['displayedName'];

    String userImage = userDoc['userImage'];

    await _cloudFirestoreServices.addBookReview(
        authors: _authors,
        bookId: _bookId,
        bookImage: _bookImage,
        bookTitle: _bookTitle,
        bookpreviewLink: _bookpreviewLink,
        userEmail: userEmail,
        userImage: userImage,
        reviewCommentsConter: 0,
        userReviewSentDate: DateTime.now(),
        userReviewEmojiRating: _newSliderValue,
        userReviewString: _reviewController.text,
        userId: userId,
        userName: displayedName,
        spoiler: _spoiler);
  }

  TextEditingController _reviewController = TextEditingController(text: '');
  TextEditingController get reviewController => _reviewController;
}
