import 'dart:async';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/bookServices.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/views/book/book_view.dart';
import 'package:boo_vi_app/views/book_author_grid/book_author_grid_view.dart';
import 'package:boo_vi_app/views/book_categories_grid/book_categories_grid_view.dart';
import 'package:boo_vi_app/views/book_reviews/book_reviews_view.dart';
import 'package:boo_vi_app/views/similer_books_grid/similer_books_grid_view.dart';
import 'package:boo_vi_app/views/book_information/book_information_view.dart';
import 'package:boo_vi_app/views/User_Revieww/User_Revieww_View.dart';
import 'package:boo_vi_app/widgets/smart_widgets/book_review_sheet/book_review_sheet_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class BookViewModel extends BaseViewModel {
  Logger log;

  BookViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  BookServices _bookServices = locator<BookServices>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  Stream getReviewsStream(String bookId) {
    return _cloudFirestoreServices.getReviewsStream(bookId);
  }

  Stream<QuerySnapshot> getUserShelfsStream() async* {
    yield* _cloudFirestoreServices.getUserShelfsStream();
  }

  Future<QuerySnapshot> getUserShelfsBooksByNameFuture(String shelfId) async {
    return _cloudFirestoreServices.getUserShelfsBooksByNameFuture(shelfId);
  }

  getBooksByVolumes({@required String volumeName}) {
    return _bookServices.getBooksByVolumes(
        volumeName: volumeName, maxResults: 10, sortBy: 'newest');
  }

  get40BooksByVolumes({@required String volumeName}) {
    return _bookServices.getBooksByVolumes(
        volumeName: volumeName, maxResults: 40, sortBy: 'newest');
  }

  getBookById({@required String id}) {
    return _bookServices.getBookById(volumeId: id);
  }

  pushBookAuthorGridView({@required String authorName}) {
    return _navigationService.navigateWithTransition(
        BookAuthorGridView(
          authorName: authorName,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  pushSimilerBooksGridView({@required String title}) {
    return _navigationService.navigateWithTransition(
        SimilerBooksGridView(
          title: title,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  pushBookCategoriesGridView({@required String bookCategories}) {
    return _navigationService.navigateWithTransition(
        BookCategoriesGridView(
          categories: bookCategories,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  String getBookcategories(String categories) {
    String char;

    for (int i = 0; i < categories.length; i++) {
      char = categories.substring(i, i + 1);
      if (char == ' ') {
        char = categories.substring(0, i);

        break;
      }
    }
    return char;
  }

  pushBookInformationView({
    @required String bookId,
    @required String webReaderLink,
    @required String buyLink,
  }) {
    _navigationService.navigateWithTransition(
        BookInformationView(
          bookId: bookId,
          webReaderLink: webReaderLink,
          buyLink: buyLink,
        ),
        transition: 'rightToLeft',
        duration: Duration(milliseconds: 400));
  }

  String getTitle(dynamic title) {
    String _title = title;

    if (_title == null)
      return 'No Title For This Book';
    else
      return _title;
  }

  pushBookView(
      {@required String id,
      @required String image,
      @required String bookTitle,
      @required String previewLink}) {
    _navigationService.navigateWithTransition(
        BookView(
          id: id,
          image: image,
          text: bookTitle,
          previewLink: previewLink,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  fabOnTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2.3,
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              ListTile(
                title: Text(
                  'Add What ?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // ! Add book to a shelf
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ListTile(
                    leading: Icon(Icons.clear_all),
                    title: Text('Add book to a shelf'),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: GestureDetector(
                              onTap: () => FocusScope.of(context).unfocus(),
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Choose your shelf',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 5),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: ListTile(
                                        leading: Icon(Icons.clear_all),
                                        title: Text('Create a new shelf'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return ListView(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      'Set a shelf name:',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TextfieldWidget(
                                                    maxLines: 3,
                                                    onSubmitted: (String
                                                        newShelfName) async {
                                                      await addANewShelfByName(
                                                          newShelfName:
                                                              newShelfName,
                                                          bookId: _bookId,
                                                          bookImage: _bookImage,
                                                          previewLink:
                                                              _bookpreviewLink,
                                                          title: _bookTitle);

                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  StreamBuilder(
                                      stream: getUserShelfsStream(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError)
                                          return snapshot.error;

                                        if (snapshot.hasData) {
                                          if (snapshot.data.size == 0) {
                                            return Container(
                                              height: 200,
                                              child: Center(
                                                  child: Text(
                                                      'Seems Like you dont have any shelf yet😭')),
                                            );
                                          }
                                          if (snapshot.data.size != 0) {
                                            List<QueryDocumentSnapshot>
                                                shelfsDocs = snapshot.data.docs;

                                            shelfsDocs.sort((a, b) {
                                              int aInt = a
                                                  .get('createdDate')
                                                  .microsecondsSinceEpoch;
                                              int bInt = b
                                                  .get('createdDate')
                                                  .microsecondsSinceEpoch;
                                              return bInt.compareTo(aInt);
                                            });
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount: shelfsDocs.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ListView(
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 20,
                                                                left: 20.0,
                                                                top: 12),
                                                        child: Container(
                                                          child: Text(
                                                            shelfsDocs[index]
                                                                ['name'],
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                      StreamBuilder(
                                                          stream: getUserBooksInThatShelfStream(
                                                              shelfName:
                                                                  shelfsDocs[
                                                                          index]
                                                                      .id),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              List<QueryDocumentSnapshot>
                                                                  booksDocs =
                                                                  snapshot.data
                                                                      .docs;

                                                              return InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  Timer(
                                                                      Duration(
                                                                        seconds:
                                                                            1,
                                                                      ), () {
                                                                    addAbooktoSelectedShelf(
                                                                        shelfId:
                                                                            shelfsDocs[index]
                                                                                .id,
                                                                        bookId:
                                                                            _bookId,
                                                                        bookImage:
                                                                            _bookImage,
                                                                        previewLink:
                                                                            _bookpreviewLink,
                                                                        title:
                                                                            _bookTitle);
                                                                  });
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      duration: Duration(
                                                                          seconds:
                                                                              3),
                                                                      content: Text(shelfsDocs[index]
                                                                              [
                                                                              'name'] +
                                                                          ' has been updated'),
                                                                    ),
                                                                  );
                                                                },
                                                                child: ListView(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      ScrollPhysics(),
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height:
                                                                          200,
                                                                      child: ListView
                                                                          .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            ScrollPhysics(),
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        itemCount: snapshot
                                                                            .data
                                                                            .size,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          booksDocs.sort((a,
                                                                              b) {
                                                                            int aInt =
                                                                                a.get('openedDate').microsecondsSinceEpoch;
                                                                            int bInt =
                                                                                b.get('openedDate').microsecondsSinceEpoch;
                                                                            return bInt.compareTo(aInt);
                                                                          });
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(12.0),
                                                                            child:
                                                                                GestureDetector(
                                                                              child: Hero(
                                                                                tag: booksDocs[index]['id'],
                                                                                child: Container(
                                                                                  height: 150,
                                                                                  width: 110,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Theme.of(context).primaryColor.withOpacity(.5),
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                    image: DecorationImage(
                                                                                      fit: BoxFit.cover,
                                                                                      image: NetworkImage(booksDocs[index]['thumbnail']),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              15,
                                                                          vertical:
                                                                              8),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            12,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          color: Theme.of(context).brightness == Brightness.dark
                                                                              ? Theme.of(context).cardColor
                                                                              : Color(0xffE7E7E7),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            }

                                                            return Container(
                                                              child: Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                            );
                                                          }),
                                                    ],
                                                  );
                                                });
                                          }
                                        }
                                        if (!snapshot.hasData) {
                                          return Container(
                                            height: 300,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                        return Container(
                                          height: 300,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              // ! Add as a challenge
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ListTile(
                    leading: Icon(Icons.timer),
                    title: Text('Add as a challenge'),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Choose the type of challenge',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 5),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: ListTile(
                                        leading: Icon(Icons.person),
                                        title:
                                            Text('Add as a personal challenge'),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 5),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: ListTile(
                                        leading: Icon(Icons.group_work),
                                        title: Text(
                                            'Add as a community challenge'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              // ! Add a review
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ListTile(
                    leading: Icon(Icons.textsms),
                    title: Text('Add a review'),
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return BookReviewSheetWidget(
                            bookId: _bookId,
                            bookImage: _bookImage,
                            bookTitle: _bookTitle,
                            bookpreviewLink: _bookpreviewLink,
                          );
                        },
                      );
                      Navigator.pop(context);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     duration: Duration(seconds: 4),
                      //     content: Text('Reviews has been updated'),
                      //   ),
                      // );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    notifyListeners();
  }

  bool _spoiler = true;

  bool get spoiler => _spoiler;

  void toggleSpoiler(bool value) {
    _spoiler = value;
    notifyListeners();
  }

  handleStartUpLogic({
    @required String bookId,
    @required String bookImage,
    @required String bookTitle,
    @required String bookpreviewLink,
  }) async {
    _bookId = bookId;
    _bookImage = bookImage;
    _bookTitle = bookTitle;
    _bookpreviewLink = bookpreviewLink;
  }

  String _bookId;
  String _bookImage;
  String _bookTitle;
  String _bookpreviewLink;
  bool _isLiked = false;
  bool get isLiked => _isLiked;

  pushBookReviews({String bookId, String tappedUserEmail}) async {
    _navigationService.navigateWithTransition(
        BookReviewsView(bookId: _bookId, tappedUserEmail: tappedUserEmail),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  pushBookUserReview({
    String bookId,
    String tappedUserEmail,
    String bookImage,
    bool spoiler,
    String userReviewString,
    double userReviewEmojiRating,
  }) async {
    String currentUserEmail = await _authenticationService.userEmail();
    bool editSpoiler;
    if (currentUserEmail == tappedUserEmail) {
      print(spoiler);
      editSpoiler = spoiler;
      spoiler = false;
    } else {
      spoiler = spoiler;
    }

    _navigationService.navigateWithTransition(
        UserReviewwView(
          tappedUserEmail: tappedUserEmail,
          bookId: _bookId,
          bookImage: bookImage,
          spoiler: spoiler,
          editSpoiler: editSpoiler,
          userReviewEmojiRating: userReviewEmojiRating,
          userReviewString: userReviewString,
          userReviewEmojiRatingDouble: userReviewEmojiRating,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }

  Future addAlikeToABook(String userEmail) async {
    await _cloudFirestoreServices.addAlikeToABook(
      bookId: _bookId,
      userEmail: await _authenticationService.userEmail(),
      otherUserReview: userEmail,
    );
  }

  Future addAbooktoSelectedShelf(
      {String shelfId,
      String bookId,
      String bookImage,
      String previewLink,
      String title}) async {
    return await _cloudFirestoreServices.addAbooktoSelectedShelf(
        shelfId: shelfId,
        bookId: bookId,
        bookImage: bookImage,
        previewLink: previewLink,
        title: title);
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

  Stream<QuerySnapshot> getBookRatingEmoji() {
    return _cloudFirestoreServices.getBookRatingEmoji(_bookId);
  }

  Stream<QuerySnapshot> getUserBooksInThatShelfStream(
      {@required String shelfName}) async* {
    yield* _cloudFirestoreServices.getUserBooksInThatShelfStream(
        shelfName: shelfName);
  }

  Future addAbookToRecentlyViewedShelf({
    @required String bookId,
    @required String bookImage,
    @required String previewLink,
    @required String title,
  }) async {
    await _cloudFirestoreServices.addAbookToRecentlyViewedShelf(
        bookId: bookId,
        title: title,
        previewLink: previewLink,
        bookImage: bookImage);
  }
}
