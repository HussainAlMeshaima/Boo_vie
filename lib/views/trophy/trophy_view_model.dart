import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class TrophyViewModel extends BaseViewModel {
  Logger log;

  TrophyViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  handleStartUpLogic({
    @required String trophyTitle,
    @required String trophyDescription,
    @required Timestamp trophyReceivedDate,
    @required String bookId,
    @required String bookImage,
    @required String previewLink,
    @required String bookAuthors,
  }) {
    _trophyTitle = trophyTitle;
    _trophyDescription = trophyDescription;
    _trophyDescription = trophyDescription;
    _trophyReceivedDate = trophyReceivedDate;
    _bookId = bookId;
    _bookImage = bookImage;
    _previewLink = previewLink;
    _bookAuthors = bookAuthors;
  }

  String _trophyTitle;
  String get trophyTitle => _trophyTitle;
  String _trophyDescription;
  String get trophyDescription => _trophyDescription;
  Timestamp _trophyReceivedDate;
  Timestamp get trophyReceivedDate => _trophyReceivedDate;
  String _bookId;
  String get bookId => _bookId;
  String _bookImage;
  String get bookImage => _bookImage;
  String _previewLink;
  String get previewLink => _previewLink;
  String _bookAuthors;
  String get bookAuthors => _bookAuthors;
}
