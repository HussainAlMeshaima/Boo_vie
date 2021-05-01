import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/bookServices.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateANewShelfWithNameViewModel extends BaseViewModel {
  Logger log;

  CreateANewShelfWithNameViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  String _bookId;
  String get bookId => _bookId;
  String _bookImage;
  String get bookImage => _bookImage;
  String _bookTitle;
  String get bookTitle => _bookTitle;
  String _bookpreviewLink;
  String get bookpreviewLink => _bookpreviewLink;
  handleStartUpLogic(
      {String bookId,
      String bookImage,
      String bookTitle,
      String bookpreviewLink}) {
    _bookId = bookId;
    _bookImage = bookImage;
    _bookTitle = bookTitle;
    _bookpreviewLink = bookpreviewLink;
  }

  TextEditingController _displayedShelfNameController =
      TextEditingController(text: '');
  TextEditingController get displayedShelfNameController =>
      _displayedShelfNameController;

  String getUsernameOnChange(char) {
    String word = _displayedShelfNameController.text + char;
    notifyListeners();
    return word;
  }

  Future addANewShelfByName(
      {String newShelfName,
      String bookId,
      String bookImage,
      String previewLink,
      String title}) async {
    await _cloudFirestoreServices.addANewShelfByName(
        newShelfName: newShelfName,
        bookId: bookId,
        bookImage: bookImage,
        previewLink: previewLink,
        title: title);
  }

  BookServices _bookServices = locator<BookServices>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();
}
