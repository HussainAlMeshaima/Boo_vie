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

  Future getUserShelfFuture() async {
    String userEmail = await _authenticationService.userEmail();
    return _cloudFirestoreServices.getUserShelfFuture(userEmail);
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
    );
  }

  pushSimilerBooksGridView({@required String title}) {
    return _navigationService.navigateWithTransition(
      SimilerBooksGridView(
        title: title,
      ),
      transition: 'rightToLeftWithFade',
    );
  }

  pushBookCategoriesGridView({@required String bookCategories}) {
    return _navigationService.navigateWithTransition(
      BookCategoriesGridView(
        categories: bookCategories,
      ),
      transition: 'rightToLeftWithFade',
    );
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
    );
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
                                  FutureBuilder(
                                    future: getUserShelfFuture(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount: snapshot
                                                  .data['shelfs'].length,
                                              itemBuilder: (context, index) {
                                                return ListView(
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20,
                                                              left: 20.0,
                                                              top: 12),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            snapshot.data[
                                                                        'shelfs']
                                                                    [index]
                                                                ['shelfName'],
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    ),
                                                    ListView(
                                                      shrinkWrap: true,
                                                      physics: ScrollPhysics(),
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12.0,
                                                                    vertical:
                                                                        5),
                                                            child: Container(
                                                              height: 150,
                                                              child: ListView(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    ScrollPhysics(),
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                children: [
                                                                  ListView.builder(
                                                                      shrinkWrap: true,
                                                                      physics: ScrollPhysics(),
                                                                      scrollDirection: Axis.horizontal,
                                                                      itemCount: snapshot.data['shelfs'][index]['books'].length,
                                                                      itemBuilder: (context, index) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical: 3,
                                                                              horizontal: 7),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                85,
                                                                            decoration:
                                                                                BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(.5), borderRadius: BorderRadius.circular(8)),
                                                                          ),
                                                                        );
                                                                      }),
                                                                  GestureDetector(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              3,
                                                                          horizontal:
                                                                              7),
                                                                      child:
                                                                          Stack(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        clipBehavior:
                                                                            Clip.none,
                                                                        children: [
                                                                          Positioned(
                                                                            right:
                                                                                -13,
                                                                            child:
                                                                                Container(
                                                                              width: 85,
                                                                              height: 120,
                                                                              decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(.3), borderRadius: BorderRadius.circular(8)),
                                                                            ),
                                                                          ),
                                                                          Positioned(
                                                                            right:
                                                                                -7,
                                                                            child:
                                                                                Container(
                                                                              width: 85,
                                                                              height: 133,
                                                                              decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(.6), borderRadius: BorderRadius.circular(8)),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                85,
                                                                            decoration:
                                                                                BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                Container(
                                                                              height: 140,
                                                                              child: Icon(
                                                                                Icons.add_rounded,
                                                                                color: Colors.white,
                                                                                size: 30,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 3,
                                                                  horizontal:
                                                                      15),
                                                          child: Container(
                                                            height: 11,
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? Theme.of(
                                                                            context)
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                            .3)
                                                                    : Theme.of(
                                                                            context)
                                                                        .cardColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        );
                                      }

                                      return Container(
                                        height: 300,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                  )
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
                      Navigator.pop(context);
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
        transition: 'rightToLeftWithFade');
  }

  pushBookUserReview({String bookId, String tappedUserEmail}) async {
    _navigationService.navigateWithTransition(
        UserReviewwView(tappedUserEmail: tappedUserEmail, bookId: _bookId),
        transition: 'rightToLeftWithFade');
  }

  Future addAlikeToABook(String userEmail) async {
    await _cloudFirestoreServices.addAlikeToABook(
      bookId: _bookId,
      userEmail: await _authenticationService.userEmail(),
      otherUserReview: userEmail,
    );
  }

  Stream<QuerySnapshot> getBookRatingEmoji() {
    return _cloudFirestoreServices.getBookRatingEmoji(_bookId);
  }
}
