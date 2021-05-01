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
  String _authors;
  String get authors => _authors;
  String _bookpreviewLink;
  String get bookpreviewLink => _bookpreviewLink;
  handleStartUpLogic({
    @required String bookId,
    @required String bookImage,
    @required String bookTitle,
    @required String authours,
    @required String bookpreviewLink,
  }) {
    _bookId = bookId;
    _authors = authours;
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
      {@required String newShelfName,
      @required String bookId,
      @required String authors,
      @required String bookImage,
      @required String previewLink,
      @required @required String title}) async {
    await _cloudFirestoreServices.addANewShelfByName(
        authors: authors,
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
