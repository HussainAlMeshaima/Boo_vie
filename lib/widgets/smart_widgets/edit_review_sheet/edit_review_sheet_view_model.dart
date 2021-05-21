import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class EditReviewSheetViewModel extends BaseViewModel {
  Logger log;

  EditReviewSheetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  handleStartUpLogic(
      {String bookId,
      bool spoiler,
      String userReviewString,
      double userReviewEmojiRating,
      bool bookPageSpoiler}) {
    _bookId = bookId;
    _spoiler = spoiler;
    _bookPageSpoiler = bookPageSpoiler;
    _userReviewString = userReviewString;
    _userReviewEmojiRating = userReviewEmojiRating;
    setReviewController();
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  void toggleSpoiler(bool value) {
    print(value);
    _bookPageSpoiler = value;
    notifyListeners();
  }

  updateSliderOriginalValue(double newValue) {
    _userReviewEmojiRating = newValue;

    notifyListeners();
  }

  void setReviewController() {
    _reviewController.text = _userReviewString;
    notifyListeners();
  }

  updateThatUserReviewForThatBook() async {
    print(_spoiler);
    await _cloudFirestoreServices.updateThatUserReviewForThatBook(
        bookId: _bookId,
        userReviewEmojiRating: _userReviewEmojiRating,
        userReviewString: _reviewController.text,
        spoiler: _bookPageSpoiler);

    DocumentSnapshot doc =
        await _cloudFirestoreServices.getThatUserReviewForThatBook(_bookId);
    _userReviewEmojiRating = doc.data()['userReviewEmojiRating'];
    _reviewController.text = doc.data()['userReviewString'];
    _spoiler = doc.data()['spoiler'];
  }

  String _bookId;
  String get bookId => _bookId;

  bool _spoiler;
  bool get spoiler => _spoiler;
  bool _bookPageSpoiler;
  bool get bookPageSpoiler => _bookPageSpoiler;

  double _userReviewEmojiRating;
  double get userReviewEmojiRating => _userReviewEmojiRating;

  String _userReviewString;
  String get userReviewString => _userReviewString;

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

  double _newSliderValue;
  double get newSliderValue => _newSliderValue;

  TextEditingController _reviewController = TextEditingController(text: '');
  TextEditingController get reviewController => _reviewController;
}
