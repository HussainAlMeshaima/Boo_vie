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

  Future<DocumentSnapshot> getUserDoc(String userEmail) {
    return FirebaseFirestore.instance.collection('users').doc(userEmail).get();
  }

  getUserCollection(String userEmail) {
    return FirebaseFirestore.instance.collection('users').doc(userEmail).get();
  }

  Stream getReviewsStream(String bookId) {
    return _bookReviewsCollection.doc(bookId).collection('reviews').snapshots();
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

  Future<DocumentSnapshot> getUserShelfFuture(String userEmail) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('userDetails')
        .doc('userShelf')
        .get();
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

  Future<String> createANewListForThatUser(
      {String userEmail, String uid, String newListName}) async {
    await _users
        .doc(userEmail)
        .collection('userDetails')
        .doc(userEmail)
        .update({})
        .then((value) => print("List created for that user"))
        .catchError((error) => print("Failed to add List: $error"));
    return 'A new shelf has been added';
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

  Future editAReview() {}

  Future addACommentToAReview({
    @required String userEmailReview,
    //
    @required String userNameComment,
    @required String userEmailComment,
    @required String userImageComment,
    @required String userComment,
    @required String bookId,
  }) {
    try {
      _bookReviewsCollection
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
                    .then((_) => _bookReviewsCollection
                            .doc(bookId)
                            .collection('reviews')
                            .doc(userEmail)
                            .set({
                          'userId': userId,
                          'userName': userName,
                          'userReviewString': userReviewString,
                          'userReviewEmojiRating': userReviewEmojiRating,
                          'userEmail': userEmail,
                          'userImage': userImage,
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
                    'userReviewString': userReviewString,
                    'userReviewEmojiRating': userReviewEmojiRating,
                    'userEmail': userEmail,
                    'userImage': userImage,
                    'reviewDateTime': DateTime.now(),
                    'reviewCommentsConter': 0,
                    'reviewLikeConter': 0,
                  }).then(
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

  futureCreateAsummyUser(Map aMap) async {
    return await FirebaseFirestore.instance
        .collection('ztst')
        .doc('12345')
        .set({'map': aMap});
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
              .doc('userShelf')
              .set(
            {
              'name': 'User Book shelf',
              'shelfs': [
                {'shelfName': 'Recently Viewed', 'books': []},
                {'shelfName': 'Currently Reading', 'books': []},
                {'shelfName': 'Favorite', 'books': []},
                {'shelfName': 'Best Books', 'books': []},
              ]
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
            {'numberOfBooksReviewed': 0, 'reviewedBooks': []},
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
}
