import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CloudFirestoreServices {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Stream<QuerySnapshot> getBookRatingEmoji(String bookId) {
    return _bookReviewsCollection.doc(bookId).collection('reviews').snapshots();
  }

  Future<DocumentSnapshot> getUserDoc() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(await _authenticationService.userEmail())
        .get();
  }

  Future<DocumentSnapshot> getUserInformation() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(await _authenticationService.userEmail())
        .collection('userDetails')
        .doc('userInformation')
        .get();
  }

  getUserCollection(String userEmail) {
    return FirebaseFirestore.instance.collection('users').doc(userEmail).get();
  }

  Stream getReviewsStream(String bookId) {
    return _bookReviewsCollection.doc(bookId).collection('reviews').snapshots();
  }

  Future<DocumentSnapshot> getThatUserReviewForThatBook(String bookId) async {
    String _userEmail = await _authenticationService.userEmail();
    return _bookReviewsCollection
        .doc(bookId)
        .collection('reviews')
        .doc(_userEmail)
        .get();
  }

  Future<void> updateThatUserReviewForThatBook(
      {String bookId,
      double userReviewEmojiRating,
      String userReviewString,
      bool spoiler}) async {
    String _userEmail = await _authenticationService.userEmail();
    _bookReviewsCollection
        .doc(bookId)
        .collection('reviews')
        .doc(_userEmail)
        .update({
      'userReviewEmojiRating': userReviewEmojiRating,
      'userReviewString': userReviewString,
      'spoiler': spoiler,
      'reviewDateTime': DateTime.now(),
    });
  }

  Stream<QuerySnapshot> getUserShelfsStream() async* {
    String _userEmail = await _authenticationService.userEmail();
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(_userEmail)
        .collection('userShelfs')
        .snapshots();
  }

  Future<QuerySnapshot> getUserShelfsBooksByNameFuture(String shelfId) async {
    String _userEmail = await _authenticationService.userEmail();
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_userEmail)
        .collection('userShelfs')
        .doc(shelfId)
        .collection('books')
        .get();
  }

  Stream<QuerySnapshot> getUserBooksInThatShelfStream(
      {@required String shelfName}) async* {
    String _userEmail = await _authenticationService.userEmail();
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(_userEmail)
        .collection('userShelfs')
        .doc(shelfName)
        .collection('books')
        .snapshots();
  }

  Future<DocumentSnapshot> getUserChallenges() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(await _authenticationService.userEmail())
        .collection('userDetails')
        .doc('userChallenges')
        .get();
  }

  Stream<QuerySnapshot> getUserGlobalChallengesStream() async* {
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(await _authenticationService.userEmail())
        .collection('userDetails')
        .doc('userChallenges')
        .collection('globalChallenges')
        .snapshots();
  }

  Stream<QuerySnapshot> getMyChallengesStream() async* {
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(await _authenticationService.userEmail())
        .collection('userDetails')
        .doc('userChallenges')
        .collection('myChallenges')
        .snapshots();
  }

  Stream<DocumentSnapshot> getUserReviewsStream(
      String bookId, String tappedUserEmail) {
    return _bookReviewsCollection
        .doc(bookId)
        .collection('reviews')
        .doc(tappedUserEmail)
        .snapshots();
  }

  Future<DocumentSnapshot> getLikeBoolValue(
      {String bookId, String tappedUserEmail}) async {
    return _bookReviewsCollection
        .doc(bookId)
        .collection('reviews')
        .doc(tappedUserEmail)
        .collection('isReviewLiked')
        .doc(await _authenticationService.userEmail())
        .get();
  }

  Stream<QuerySnapshot> getReviewComments(
      {String bookId, String tappedUserEmail}) {
    return _bookReviewsCollection
        .doc(bookId)
        .collection('reviews')
        .doc(tappedUserEmail)
        .collection('comments')
        .snapshots();
  }

  getUserDisplayedName(String userEmail) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('userDetails')
        .doc('userInformation')
        .get();
  }

  // ! Collections
  CollectionReference _bookReviewsCollection =
      FirebaseFirestore.instance.collection('bookReviews');

  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  Future addAbooktoSelectedShelf(
      {String shelfId,
      String bookId,
      String bookImage,
      String previewLink,
      String title}) async {
    await _users
        .doc(await _authenticationService.userEmail())
        .collection('userShelfs')
        .doc(shelfId)
        .collection('books')
        .doc(bookId)
        .set({
      'id': bookId,
      'thumbnail': bookImage,
      'previewLink': previewLink,
      'title': title,
      'openedDate': DateTime.now()
    });
  }

  Future<void> addANewShelfByName(
      {String newShelfName,
      String bookId,
      String bookImage,
      String previewLink,
      String title}) async {
    String userEmail = await _authenticationService.userEmail();
    await _users
        .doc(userEmail)
        .collection('userShelfs')
        .doc(newShelfName)
        .get()
        .then((thatShelf) async => {
              if (!thatShelf.exists)
                {
                  await _users
                      .doc(userEmail)
                      .collection('userShelfs')
                      .doc(newShelfName)
                      .set({
                    'name': newShelfName,
                    'createdDate': DateTime.now(),
                  }).then((value) async => {
                            await _users
                                .doc(userEmail)
                                .collection('userShelfs')
                                .doc(newShelfName)
                                .collection('books')
                                .doc(bookId)
                                .set({
                              'id': bookId,
                              'thumbnail': bookImage,
                              'previewLink': previewLink,
                              'title': title,
                              'openedDate': DateTime.now()
                            })
                          })
                }
              else
                await _users
                    .doc(userEmail)
                    .collection('userShelfs')
                    .doc(newShelfName)
                    .collection('books')
                    .doc(bookId)
                    .set({
                  'id': bookId,
                  'thumbnail': bookImage,
                  'previewLink': previewLink,
                  'title': title,
                  'openedDate': DateTime.now()
                })
            });
  }

  Future getUserReviewToBeEdited() {
    //await
  }

  Future<void> addAbookToRecentlyViewedShelf(
      {@required String bookId,
      @required String bookImage,
      @required String previewLink,
      @required String title}) async {
    String userEmail = await _authenticationService.userEmail();
    await _users
        .doc(userEmail)
        .collection('userShelfs')
        .doc('recentlyViewed')
        .get()
        .then(
          (thatDoc) async => {
            if (!thatDoc.exists)
              {
                await _users
                    .doc(userEmail)
                    .collection('userShelfs')
                    .doc('recentlyViewed')
                    .set({
                  'name': 'Recently viewed shelf',
                  'createdDate': DateTime.now(),
                }).then((value) async => {
                          await _users
                              .doc(userEmail)
                              .collection('userShelfs')
                              .doc('recentlyViewed')
                              .collection('books')
                              .doc(bookId)
                              .set({
                            'id': bookId,
                            'thumbnail': bookImage,
                            'previewLink': previewLink,
                            'title': title,
                            'openedDate': DateTime.now()
                          })
                        })
              }
            else
              await _users
                  .doc(userEmail)
                  .collection('userShelfs')
                  .doc('recentlyViewed')
                  .collection('books')
                  .doc(bookId)
                  .set({
                'id': bookId,
                'thumbnail': bookImage,
                'previewLink': previewLink,
                'title': title,
                'openedDate': DateTime.now()
              })
          },
        );
  }

  Future<void> addAbookMyReviewsShelfViewedShelf(
      {@required String bookId,
      @required String bookImage,
      @required String previewLink,
      @required String title}) async {
    String userEmail = await _authenticationService.userEmail();
    await _users
        .doc(userEmail)
        .collection('userShelfs')
        .doc('myReviews')
        .get()
        .then(
          (thatDoc) async => {
            if (!thatDoc.exists)
              {
                await _users
                    .doc(userEmail)
                    .collection('userShelfs')
                    .doc('myReviews')
                    .set({
                  'name': 'My reviews shelf',
                  'createdDate': DateTime.now(),
                }).then((value) async => {
                          await _users
                              .doc(userEmail)
                              .collection('userShelfs')
                              .doc('myReviews')
                              .collection('books')
                              .doc(bookId)
                              .set({
                            'id': bookId,
                            'thumbnail': bookImage,
                            'previewLink': previewLink,
                            'title': title,
                            'openedDate': DateTime.now()
                          })
                        })
              }
            else
              await _users
                  .doc(userEmail)
                  .collection('userShelfs')
                  .doc('myReviews')
                  .collection('books')
                  .doc(bookId)
                  .set({
                'id': bookId,
                'thumbnail': bookImage,
                'previewLink': previewLink,
                'title': title,
                'openedDate': DateTime.now()
              })
          },
        );
  }

  Future createAChallage({
    // users Information
    @required String userEmail,
    @required String userName,

    // challage Information
    @required String challageName,
    @required String challageDiscription,
    @required DateTime challageToWhichDay,
    @required String bookId,
    List<String> challageRules,
    bool isChallangePublicForEveryOne,
    String challageImage,
    //
    List<String> availableInCommunitys,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .collection('userChallenges')
          .add({
        // users Information
        'userEmail': userEmail,
        'userName': userName,

        // challage Information
        'bookId': bookId,
        'challageName': challageName ?? 'Not Set',
        'challageImage': challageImage ?? 'Not Set',
        'challageDiscription': challageDiscription ?? 'Not Set',

        'whichDayisTheChallageCreated': DateTime.now(),
        'tillWhichDayTheChallageEnds': challageToWhichDay ?? 'Not Set',

        // ! Rules
        'isChallangePublicForEveryOne': isChallangePublicForEveryOne ?? false,
        'challageRules': challageRules ?? ['No Rules Set.'],
        'availableInCommunitys': availableInCommunitys ?? ['None'],
      }).then((value) =>
              print('A new $challageName challage has been added !'));
    } catch (e) {
      return 'Error';
    }
  }

  Future editAChallage({
    // users Information
    @required String userEmail,
    @required String userName,

    // challage Information
    @required String challageName,
    @required String challageDiscription,
    @required DateTime challageToWhichDay,
    @required String bookId,
    List<String> challageRules,
    bool isChallangePublicForEveryOne,
    String challageImage,
    //
    List<String> availableInCommunitys,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .collection('userChallenges')
          .doc(challageName)
          .update({
        // users Information
        'userEmail': userEmail,
        'userName': userName ?? 'No User',

        // challage Information
        'bookId': bookId,
        'challageName': challageName ?? 'Not Set',
        'challageImage': challageImage ?? 'Not Set',
        'challageDiscription': challageDiscription ?? 'Not Set',

        'whichDayisTheChallageModifyed': DateTime.now(),
        'tillWhichDayTheChallageEnds': challageToWhichDay ?? 'Not Set',

        // ! Rules
        'isChallangePublicForEveryOne': isChallangePublicForEveryOne ?? false,
        'challageRules': challageRules ?? ['No Rules Set.'],
        'availableInCommunitys': availableInCommunitys ?? ['None'],
      });
    } catch (e) {
      return e.toString();
    }
  }

  addAlikeToABook({
    // @required String userName,
    @required String userEmail,
    @required String otherUserReview,
    //
    @required String bookId,
  }) {
    try {
      _bookReviewsCollection
          .doc(bookId)
          .collection('reviews')
          .doc(otherUserReview)
          .collection('isReviewLiked')
          .doc(userEmail)
          .get()
          .then((doc) => {
                if (otherUserReview != userEmail)
                  {
                    if (!doc.exists)
                      {
                        _bookReviewsCollection
                            .doc(bookId)
                            .collection('reviews')
                            .doc(otherUserReview)
                            .collection('isReviewLiked')
                            .doc(userEmail)
                            .set({'isReviewLiked': true}).then((value) => {
                                  _bookReviewsCollection
                                      .doc(bookId)
                                      .collection('reviews')
                                      .doc(otherUserReview)
                                      .update({
                                    'reviewLikeConter': FieldValue.increment(1)
                                  })
                                })
                      }
                    else
                      {
                        _bookReviewsCollection
                            .doc(bookId)
                            .collection('reviews')
                            .doc(otherUserReview)
                            .collection('isReviewLiked')
                            .doc(userEmail)
                            .update({
                          'isReviewLiked': !doc.data()['isReviewLiked']
                        }).then((value) => {
                                  _bookReviewsCollection
                                      .doc(bookId)
                                      .collection('reviews')
                                      .doc(otherUserReview)
                                      .update({
                                    if (!doc.data()['isReviewLiked'])
                                      'reviewLikeConter':
                                          FieldValue.increment(1)
                                    else
                                      'reviewLikeConter':
                                          FieldValue.increment(-1)
                                  })
                                })
                      }
                  }
                else
                  {
                    if (!doc.exists)
                      {
                        _bookReviewsCollection
                            .doc(bookId)
                            .collection('reviews')
                            .doc(otherUserReview)
                            .collection('isReviewLiked')
                            .doc(userEmail)
                            .set({'isReviewLiked': false}).then((value) => {
                                  _bookReviewsCollection
                                      .doc(bookId)
                                      .collection('reviews')
                                      .doc(otherUserReview)
                                      .update({
                                    'reviewLikeConter': FieldValue.increment(1)
                                  })
                                })
                      }
                    else
                      {
                        _bookReviewsCollection
                            .doc(bookId)
                            .collection('reviews')
                            .doc(otherUserReview)
                            .collection('isReviewLiked')
                            .doc(userEmail)
                            .update({
                          'isReviewLiked': !doc.data()['isReviewLiked']
                        }).then((value) => {
                                  _bookReviewsCollection
                                      .doc(bookId)
                                      .collection('reviews')
                                      .doc(otherUserReview)
                                      .update({
                                    if (!doc.data()['isReviewLiked'])
                                      'reviewLikeConter':
                                          FieldValue.increment(1)
                                    else
                                      'reviewLikeConter':
                                          FieldValue.increment(-1)
                                  })
                                })
                      }
                  }
              })
          .then((value) => print('Like added'));
    } catch (e) {}
  }

  Future addACommentToAGlobalChallange({
    @required String challangeId,

    //
    @required String userNameComment,
    @required String userImageComment,
    @required String userComment,
    @required String bookId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('globalChallenges')
          .doc(challangeId)
          .collection('challangeComments')
          .doc(await _authenticationService.userEmail())
          .get()
          .then((thatDoc) async => {
                if (!thatDoc.exists)
                  {
                    await FirebaseFirestore.instance
                        .collection('globalChallenges')
                        .doc(challangeId)
                        .collection('challangeComments')
                        .doc(await _authenticationService.userEmail())
                        .set({
                      'bookId': bookId,
                      'userEmailComment':
                          await _authenticationService.userEmail(),
                      'userImageComment': userImageComment,
                      'userNameComment': userNameComment,
                      'userComment': userComment,
                      'sendDate': DateTime.now(),
                    }).then((value) async => {
                              await FirebaseFirestore.instance
                                  .collection('globalChallenges')
                                  .doc(challangeId)
                                  .update({
                                'numberOfCommentsCount':
                                    FieldValue.increment(1),
                              })
                            })
                  }
                else
                  await FirebaseFirestore.instance
                      .collection('globalChallenges')
                      .doc(challangeId)
                      .collection('challangeComments')
                      .doc(await _authenticationService.userEmail())
                      .update({
                    'userComment': userComment,
                  })
              })
          .then((value) => print('A comment has been added'));
    } catch (e) {}
  }

  Future addACommentToAReview({
    @required String userEmailReview,
    //
    @required String userNameComment,
    @required String userEmailComment,
    @required String userImageComment,
    @required String userComment,
    @required String bookId,
  }) async {
    try {
      await _bookReviewsCollection
          .doc(bookId)
          .collection('reviews')
          .doc(userEmailReview)
          .collection('comments')
          .doc(userEmailComment)
          .get()
          .then((thatDoc) => {
                if (!thatDoc.exists)
                  {
                    _bookReviewsCollection
                        .doc(bookId)
                        .collection('reviews')
                        .doc(userEmailReview)
                        .collection('comments')
                        .doc(userEmailComment)
                        .set({
                      'userEmailReview': userEmailReview,
                      'userEmailComment': userEmailComment,
                      'userImageComment': userImageComment,
                      'userNameComment': userNameComment,
                      'userComment': userComment,
                      'bookId': bookId,
                      'sendDate': DateTime.now(),
                    }).then((value) => {
                              _bookReviewsCollection
                                  .doc(bookId)
                                  .collection('reviews')
                                  .doc(userEmailReview)
                                  .update({
                                'reviewCommentsConter': FieldValue.increment(1)
                              })
                            })
                  }
                else
                  _bookReviewsCollection
                      .doc(bookId)
                      .collection('reviews')
                      .doc(userEmailReview)
                      .collection('comments')
                      .doc(userEmailComment)
                      .update({
                    'userComment': userComment,
                  })
              })
          .then((value) => print('A comment has been added'));
    } catch (e) {}
  }

  Future<String> addBookReview({
    @required String userId,
    @required String userName,
    @required String userEmail,
    @required String userImage,
    //
    @required String bookId,
    @required String bookImage,
    @required String bookTitle,
    @required String bookpreviewLink,
    //
    @required String userReviewString,
    @required DateTime userReviewSentDate,
    @required double userReviewEmojiRating,
    //
    double reviewLikeConter,
    double reviewCommentsConter,
    bool isReviewLiked,
    bool spoiler,
  }) async {
    try {
      await _bookReviewsCollection
          .doc(bookId)
          .get()
          .then(
            (thatDocument) {
              if (!thatDocument.exists) {
                print('thatDocument.id = ' + thatDocument.id);
                print('userEmail = ' + userEmail);
                _bookReviewsCollection
                    .doc(bookId)
                    .set(
                      {
                        'bookId': bookId,
                        'bookImage': bookImage,
                        'bookTitle': bookTitle,
                        'bookPreviewLink': bookpreviewLink,
                      },
                    )
                    .then((value) => addAbookMyReviewsShelfViewedShelf(
                        bookId: bookId,
                        title: bookTitle,
                        bookImage: bookImage,
                        previewLink: bookpreviewLink))
                    .then((_) => _bookReviewsCollection
                            .doc(bookId)
                            .collection('reviews')
                            .doc(userEmail)
                            .set({
                          'userId': userId,
                          'bookImage': bookImage,
                          'userName': userName,
                          'userReviewString': userReviewString,
                          'userReviewEmojiRating': userReviewEmojiRating,
                          'userEmail': userEmail,
                          'userImage': userImage,
                          'spoiler': spoiler,
                          'reviewDateTime': DateTime.now(),
                          'reviewCommentsConter': 0,
                          'reviewLikeConter': 0,
                        }))
                    .then(
                      (_) => _bookReviewsCollection
                          .doc(bookId)
                          .collection('reviews')
                          .doc(userEmail)
                          .collection('isReviewLiked')
                          .doc(userEmail)
                          .set(
                        {'isReviewLiked': false},
                      ),
                    );
              } else if (thatDocument.exists) {
                if (thatDocument.id == userEmail)
                  _bookReviewsCollection
                      .doc(bookId)
                      .collection('reviews')
                      .doc(userEmail)
                      .update({
                    'userReviewString': userReviewString,
                    'userReviewEmojiRating': userReviewEmojiRating,
                  });
                else {
                  _bookReviewsCollection
                      .doc(bookId)
                      .collection('reviews')
                      .doc(userEmail)
                      .set({
                        'userId': userId,
                        'userName': userName,
                        'bookImage': bookImage,
                        'userReviewString': userReviewString,
                        'userReviewEmojiRating': userReviewEmojiRating,
                        'userEmail': userEmail,
                        'userImage': userImage,
                        'spoiler': spoiler,
                        'reviewDateTime': DateTime.now(),
                        'reviewCommentsConter': 0,
                        'reviewLikeConter': 0,
                      })
                      .then((value) => addAbookMyReviewsShelfViewedShelf(
                          bookId: bookId,
                          title: bookTitle,
                          bookImage: bookImage,
                          previewLink: bookpreviewLink))
                      .then(
                        (_) => _bookReviewsCollection
                            .doc(bookId)
                            .collection('reviews')
                            .doc(userEmail)
                            .collection('isReviewLiked')
                            .doc(userEmail)
                            .set(
                          {'isReviewLiked': false},
                        ),
                      );
                }
              }
            },
          )
          .then((value) => _users
              .doc(userEmail)
              .update({'userTotalPoints': FieldValue.increment(2)}))
          .then((value) => {
                _users
                    .doc(userEmail)
                    .collection('userDetails')
                    .doc('userInformation')
                    .update({'userTotalPoints': FieldValue.increment(2)})
              })
          .then((value) => {
                _users
                    .doc(userEmail)
                    .update({'numberOfBookReviwed': FieldValue.increment(1)})
              });
    } catch (e) {
      return e.toString();
    }
  }

  Future createNewUser({
    @required String uid,
    @required String userName,
    @required String userEmail,
    @required String userDescription,
    @required String userImageUrl,
    @required Map userCategories,
    @required int totalNumberOfSelectedCategories,
  }) async {
    return await _users.doc(userEmail).set({
      'userId': uid,
      'displayedName': userName,
      'userEmail': userEmail,
      'userTotalPoints': 0,
      'userNotifications': [],
      'userImage': userImageUrl,
    }).then((_) => _users
        .doc(userEmail)
        .collection('userDetails')
        .doc('userInformation')
        .set(
          {
            'userId': uid,
            'userName': userName,
            'userEmail': userEmail,
            'userImage': userImageUrl,
            'userDescription': userDescription,
            'numberOfBookReviwed': 0,
            'userTotalPoints': 0,
            'joinedDate': DateTime.now().day.toString() +
                ' / ' +
                DateTime.now().month.toString() +
                ' / ' +
                DateTime.now().year.toString(),
            'joinedTime': DateTime.now().hour.toString() +
                ' : ' +
                DateTime.now().minute.toString() +
                ' : ' +
                DateTime.now().second.toString(),
            'userTrophys': {
              'newUserTrophy': {
                'trophyTitle': 'New User',
                'trophyImage': '',
                'trophyDescription': 'Welcome To BooVie.'
              }
            },
          },
        )
        .then(
          (_) => _users
              .doc(userEmail)
              .collection('userDetails')
              .doc('userChallenges')
              .set({'challenges': 'User challenges'}),
        )
        .then(
          (_) => _users
              .doc(userEmail)
              .collection('userDetails')
              .doc('userShelf')
              .set(
            {
              'name': 'User Books shelf',
              'createdDate': DateTime.now(),
              'recentlyViewed': {'name': 'Recently viewed', 'books': {}},
            },
          ),
        )
        .then(
          (_) => _users
              .doc(userEmail)
              .collection('userDetails')
              .doc('userCategories')
              .set(
            {
              'totalNumberOfSelectedCategories':
                  totalNumberOfSelectedCategories ?? 0,
              'userCategories': userCategories
            },
          ),
        )
        .then(
          (_) => _users
              .doc(userEmail)
              .collection('userDetails')
              .doc('userReviewedBooks')
              .set(
            {'numberOfBooksReviewed': 0},
          ),
        )
        .then((value) => print("New User Added"))
        .catchError((error) => print("Failed to add user: $error")));
  }

  Future<DocumentSnapshot> getIsLikedBoolDoc(String bookId) async {
    return FirebaseFirestore.instance
        .collection('bookReviews')
        .doc(bookId)
        .collection('reviews')
        .doc(await _authenticationService.userEmail())
        .collection('isReviewLiked')
        .doc(await _authenticationService.userEmail())
        .get();
  }

  createDocBasedOnSelected(
      List<bool> isSelected,
      List<String> namesOfCatigoires,
      List<Map> catigoiresMap,
      int totalNumberOfSelectedCategories) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(await _authenticationService.userEmail())
          .collection('userDetails')
          .doc('userCategories')
          .set({
        'totalNumberOfSelectedCategories': totalNumberOfSelectedCategories
      }).then((value) async => {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(await _authenticationService.userEmail())
                    .collection('userDetails')
                    .doc('userCategories')
                    .set({'catigoiresMap': catigoiresMap})
              });
    } catch (e) {}
  }

  Future addTheSelectedChallangeToMyChallanges(
      {@required int trophiesCount,
      @required Map trophiesMap,
      @required int numberOfCommunitiesWhoHasThatChallangeCount,
      @required int numberOfCommentsCount,
      @required int challengeLikeCounter,
      @required List challengeRules,
      @required String challengeDiscription,
      @required Timestamp setToDate,
      @required String bookTitle,
      @required String previewLink,
      @required String challengeName,
      @required String challengeAuthors,
      @required String challengeImage,
      @required String challangeId,
      @required String bookId}) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(await _authenticationService.userEmail())
        .collection('userDetails')
        .doc('userChallenges')
        .collection('globalChallenges')
        .doc(challangeId)
        .get()
        .then((thatDoc) async => {
              if (!thatDoc.exists)
                {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(await _authenticationService.userEmail())
                      .collection('userDetails')
                      .doc('userChallenges')
                      .collection('globalChallenges')
                      .doc(challangeId)
                      .set({
                    'numberOfCommentsCount': numberOfCommentsCount,
                    'numberOfPeopleWhoHasThatChallengeCount': 0,
                    'numberOfCommunitiesWhoHasThatChallangeCount':
                        numberOfCommunitiesWhoHasThatChallangeCount,
                    'trophiesCount': trophiesCount,
                    'trophiesMap': trophiesMap,
                    'challengeRules': challengeRules,
                    'challengeDiscription': challengeDiscription,
                    'setToDate': setToDate,
                    'bookTitle': bookTitle,
                    'previewLink': previewLink,
                    'challengeName': challengeName,
                    'challengeAuthors': challengeAuthors,
                    'challengeImage': challengeImage,
                    'challengeLikeCounter': challengeLikeCounter,
                    'challangeId': challangeId,
                    'id': bookId,
                  })
                }
            });
  }
}
