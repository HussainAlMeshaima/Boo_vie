import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:boo_vi_app/views/more_books/more_books_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  Logger log;

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  StreamServices _streamServices = locator<StreamServices>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future<DocumentSnapshot> getUserCategories() async {
    return _streamServices
        .getUserCategories(await _authenticationService.userEmail());
  }

  pushMoreBooksView({Stream stream, String text}) {
    _navigationService.navigateWithTransition(
        MoreBooksView(
          stream: stream,
          text: text,
        ),
        transition: 'rightToLeftWithFade');
  }

  pushBookView(
      {@required String id,
      @required String image,
      @required String bookTitle,
      @required String previewLink,
      @required String authors}) {
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

  Stream getFullArtsAndentErtainmentBooksStream() {
    return _streamServices.getFullArtsAndentErtainmentBooksStream();
  }

  Stream getArtsAndentErtainmentBooksStream() {
    return _streamServices.getArtsAndentErtainmentBooksStream();
  }

  Stream getFullBiographiesAndMemoirsBooksStream() {
    return _streamServices.getFullBiographiesAndMemoirsBooksStream();
  }

  Stream getBiographiesAndMemoirsBooksStream() {
    return _streamServices.getBiographiesAndMemoirsBooksStream();
  }

  Stream getFullBusinessAndInvestingBooksStream() {
    return _streamServices.getFullBusinessAndInvestingBooksStream();
  }

  Stream getBusinessAndInvestingBooksStream() {
    return _streamServices.getBusinessAndInvestingBooksStream();
  }

  Stream getFullChildrensBooksStream() {
    return _streamServices.getFullChildrensBooksStream();
  }

  Stream getChildrensBooksStream() {
    return _streamServices.getChildrensBooksStream();
  }

  Stream getComicBooksStream() {
    return _streamServices.getComicBooksStream();
  }

  Stream getFullComicBooksStream() {
    return _streamServices.getFullComicBooksStream();
  }

  Stream getFullComputersAndTechnologyBooksStream() {
    return _streamServices.getFullComputersAndTechnologyBooksStream();
  }

  Stream getComputersAndTechnologyBooksStream() {
    return _streamServices.getComputersAndTechnologyBooksStream();
  }

  Stream getFullCookingAndFoodBooksStream() {
    return _streamServices.getFullCookingAndFoodBooksStream();
  }

  Stream getCookingAndFoodBooksStream() {
    return _streamServices.getCookingAndFoodBooksStream();
  }

  Stream getFullFictionAndLiteratureBooksStream() {
    return _streamServices.getFullFictionAndLiteratureBooksStream();
  }

  Stream getFictionAndLiteratureBooksStream() {
    return _streamServices.getFictionAndLiteratureBooksStream();
  }

  Stream getFullHealthMindAndbodyBooksStream() {
    return _streamServices.getFullHealthMindAndbodyBooksStream();
  }

  Stream getHealthMindAndbodyBooksStream() {
    return _streamServices.getHealthMindAndbodyBooksStream();
  }

  Stream getFullHistoryBooksStream() {
    return _streamServices.getFullHistoryBooksStream();
  }

  Stream getHistoryBooksStream() {
    return _streamServices.getHistoryBooksStream();
  }

  Stream getFullHomeAndGardenBooksStream() {
    return _streamServices.getFullHomeAndGardenBooksStream();
  }

  Stream getHomeAndGardenBooksStream() {
    return _streamServices.getHomeAndGardenBooksStream();
  }

  Stream getFullMysteryAndThrillersBooksStream() {
    return _streamServices.getFullMysteryAndThrillersBooksStream();
  }

  Stream getMysteryAndThrillersBooksStream() {
    return _streamServices.getMysteryAndThrillersBooksStream();
  }

  Stream getFullScienceFictionAndFantasyBooksStream() {
    return _streamServices.getFullScienceFictionAndFantasyBooksStream();
  }

  Stream getScienceFictionAndFantasyBooksStream() {
    return _streamServices.getScienceFictionAndFantasyBooksStream();
  }

  Stream getFullSportsBooksStream() {
    return _streamServices.getFullSportsBooksStream();
  }

  Stream getSportsBooksStream() {
    return _streamServices.getSportsBooksStream();
  }

  Stream getTravelBooksStream() {
    return _streamServices.getTravelBooksStream();
  }

  Stream getFullTravelBooksStream() {
    return _streamServices.getFullTravelBooksStream();
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

  Future<QuerySnapshot> getUserCurrentlyReadingBooks() async {
    return _cloudFirestoreServices.getUserCurrentlyReadingBooks();
  }

  Stream<QuerySnapshot> getUserCurrentlyReadingBooksStream() async* {
    yield* _cloudFirestoreServices.getUserCurrentlyReadingBooksStream();
  }
}
