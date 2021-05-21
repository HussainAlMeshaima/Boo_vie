import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/models/bookModels/booksResponseModel.dart';
import 'package:boo_vi_app/core/services/bookServices.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchedViewModel extends BaseViewModel {
  Logger log;

  SearchedViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  pushBookView(
      {@required String id,
      @required String image,
      @required String bookTitle,
      @required String previewLink,
      @required String authors,
      @required int bookIndex}) {
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

  String _dropdownValueNameFilter = 'Title';
  String get dropdownValueNameFilter => _dropdownValueNameFilter;
  int _dropdownValueNumber = 3;
  int get dropdownValueNumber => _dropdownValueNumber;
  String _dropdownValueSortBy = 'Relevance';
  String get dropdownValueSortBy => _dropdownValueSortBy;

  changeDropdownValueNameFilter(String newValue) {
    _dropdownValueNameFilter = newValue;
    notifyListeners();
  }

  changeDropdownValueNumber(int newValue) {
    _dropdownValueNumber = newValue;
    notifyListeners();
  }

  changeDropdownValue(String newValue) {
    _dropdownValueNameFilter = newValue;
    notifyListeners();
  }

  changeDropdownValueSortBy(String newValue) {
    _dropdownValueSortBy = newValue;
    notifyListeners();
  }

  BookServices _bookServices = locator<BookServices>();

  Future<BooksResponse> getSearchedBooks() async {
    var books;

    if (_dropdownValueNameFilter == 'Title') {
      if (_searchTextfieldController.text.isEmpty) {}
      books = await _bookServices.getBooksByVolumes(
          volumeName: _searchTextfieldController.text,
          maxResults: 40,
          sortBy: _dropdownValueSortBy);
    }
    if (_dropdownValueNameFilter == 'Categories') {
      books = await _bookServices.getBooksByCategories(
          categoriesName: _searchTextfieldController.text,
          maxResults: 40,
          sortBy: _dropdownValueSortBy);
    }
    if (_dropdownValueNameFilter == 'Author') {
      books = await _bookServices.getBooksByAuthor(
          authorName: _searchTextfieldController.text,
          maxResults: 40,
          sortBy: _dropdownValueSortBy);
    }
    if (_dropdownValueNameFilter == 'Publisher') {
      books = await _bookServices.getBooksByPublisher(
          publisherName: _searchTextfieldController.text,
          maxResults: 40,
          sortBy: _dropdownValueSortBy);
    }
    if (_dropdownValueNameFilter == 'ISBN') {
      books = await _bookServices.getBooksByISBN(
          isbn: _searchTextfieldController.text,
          maxResults: 39,
          sortBy: _dropdownValueSortBy);
    }

    return await books;
  }

  Future<BooksResponse> changesearchTextfieldControllerAndBringBooks() async {
    var books = getSearchedBooks();
    // notifyListeners();

    return books;
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();
  Future addAbookToRecentlyViewedShelf({
    @required String bookId,
    @required String bookImage,
    @required String previewLink,
    @required String title,
    @required String authors,
  }) async {
    await _cloudFirestoreServices.addAbookToRecentlyViewedShelf(
        authors: authors,
        bookId: bookId,
        title: title,
        previewLink: previewLink,
        bookImage: bookImage);
  }

  handleStartUpLogic(String text) {
    _searchTextfieldController.text = text;
  }

  TextEditingController _searchTextfieldController =
      TextEditingController(text: '');
  TextEditingController get searchTextfieldController =>
      _searchTextfieldController;
}
