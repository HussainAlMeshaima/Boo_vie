import 'package:cloud_firestore/cloud_firestore.dart';

class StreamServices {
  FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserCategories(String userEmail) {
    return _firebaseFirestoreInstance
        .collection('users')
        .doc(userEmail)
        .collection('userDetails')
        .doc('userCategories')
        .get();
  }

  Stream getComicBooksStream() {
    return _firebaseFirestoreInstance
        .collection('comicBooks')
        .limit(10)
        .snapshots();
  }

  Stream getfullComicBooksStream() {
    return _firebaseFirestoreInstance.collection('comicBooks').snapshots();
  }

  Stream getNewestBooksStream() {
    return _firebaseFirestoreInstance
        .collection('newestBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullNewestBooksStream() {
    return _firebaseFirestoreInstance.collection('newestBooks').snapshots();
  }

  Stream getTravelBooksStream() {
    return _firebaseFirestoreInstance
        .collection('travelBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullTravelBooksStream() {
    return _firebaseFirestoreInstance.collection('travelBooks').snapshots();
  }

  Stream getFullArtsAndentErtainmentBooksStream() {
    return _firebaseFirestoreInstance
        .collection('artsandentertainmentBooks')
        .snapshots();
  }

  Stream getArtsAndentErtainmentBooksStream() {
    return _firebaseFirestoreInstance
        .collection('artsandentertainmentBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullHistoryBooksStream() {
    return _firebaseFirestoreInstance.collection('historyBooks').snapshots();
  }

  Stream getHistoryBooksStream() {
    return _firebaseFirestoreInstance
        .collection('historyBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullBiographiesAndMemoirsBooksStream() {
    return _firebaseFirestoreInstance
        .collection('biographiesandmemoirsBooks')
        .snapshots();
  }

  Stream getBiographiesAndMemoirsBooksStream() {
    return _firebaseFirestoreInstance
        .collection('biographiesandmemoirsBooks')
        .limit(10)
        .snapshots();
  }
}
