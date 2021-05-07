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

  Stream<QuerySnapshot> getGlobalChallengesStream() {
    return _firebaseFirestoreInstance
        .collection('globalChallenges')
        .snapshots();
  }

  Stream<DocumentSnapshot> getGlobalChallengeStream(String challangeId) {
    return _firebaseFirestoreInstance
        .collection('globalChallenges')
        .doc(challangeId)
        .snapshots();
  }

  Stream getFullArtsAndentErtainmentBooksStream() {
    return _firebaseFirestoreInstance
        .collection('artsandentertainmentBooks')
        .snapshots();
  }

  Stream<QuerySnapshot> getArtsAndentErtainmentBooksStream() {
    return _firebaseFirestoreInstance
        .collection('artsandentertainmentBooks')
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

  Stream getFullBusinessAndInvestingBooksStream() {
    return _firebaseFirestoreInstance
        .collection('businessAndInvestingBooks')
        .snapshots();
  }

  Stream getBusinessAndInvestingBooksStream() {
    return _firebaseFirestoreInstance
        .collection('businessAndInvestingBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullChildrensBooksStream() {
    return _firebaseFirestoreInstance.collection('childrensBooks').snapshots();
  }

  Stream getChildrensBooksStream() {
    return _firebaseFirestoreInstance
        .collection('childrensBooks')
        .limit(10)
        .snapshots();
  }

  Stream getComicBooksStream() {
    return _firebaseFirestoreInstance
        .collection('comicBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullComicBooksStream() {
    return _firebaseFirestoreInstance.collection('comicBooks').snapshots();
  }

  Stream getComputersAndTechnologyBooksStream() {
    return _firebaseFirestoreInstance
        .collection('computersAndTechnologyBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullComputersAndTechnologyBooksStream() {
    return _firebaseFirestoreInstance
        .collection('computersAndTechnologyBooks')
        .snapshots();
  }

  Stream getCookingAndFoodBooksStream() {
    return _firebaseFirestoreInstance
        .collection('cookingAndFoodBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullCookingAndFoodBooksStream() {
    return _firebaseFirestoreInstance
        .collection('cookingAndFoodBooks')
        .snapshots();
  }

  Stream getFictionAndLiteratureBooksStream() {
    return _firebaseFirestoreInstance
        .collection('fictionAndLiteratureBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullFictionAndLiteratureBooksStream() {
    return _firebaseFirestoreInstance
        .collection('fictionAndLiteratureBooks')
        .snapshots();
  }

  Stream getHealthMindAndbodyBooksStream() {
    return _firebaseFirestoreInstance
        .collection('healthMindAndbodyBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullHealthMindAndbodyBooksStream() {
    return _firebaseFirestoreInstance
        .collection('healthMindAndbodyBooks')
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

  Stream getFullHomeAndGardenBooksStream() {
    return _firebaseFirestoreInstance
        .collection('homeAndGardenBooks')
        .snapshots();
  }

  Stream getHomeAndGardenBooksStream() {
    return _firebaseFirestoreInstance
        .collection('homeAndGardenBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullMysteryAndThrillersBooksStream() {
    return _firebaseFirestoreInstance
        .collection('mysteryAndThrillersBooks')
        .snapshots();
  }

  Stream getMysteryAndThrillersBooksStream() {
    return _firebaseFirestoreInstance
        .collection('mysteryAndThrillersBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullScienceFictionAndFantasyBooksStream() {
    return _firebaseFirestoreInstance
        .collection('scienceFictionAndFantasyBooks')
        .snapshots();
  }

  Stream getScienceFictionAndFantasyBooksStream() {
    return _firebaseFirestoreInstance
        .collection('scienceFictionAndFantasyBooks')
        .limit(10)
        .snapshots();
  }

  Stream getFullSportsBooksStream() {
    return _firebaseFirestoreInstance.collection('sportsBooks').snapshots();
  }

  Stream getSportsBooksStream() {
    return _firebaseFirestoreInstance
        .collection('sportsBooks')
        .limit(10)
        .snapshots();
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

  Stream<DocumentSnapshot> getChallangeDocument(String challangeId) {
    return _firebaseFirestoreInstance
        .collection('globalChallenges')
        .doc(challangeId)
        .snapshots();
  }

  Stream<QuerySnapshot> getChallangeComments(String challangeId) {
    return _firebaseFirestoreInstance
        .collection('globalChallenges')
        .doc(challangeId)
        .collection('challangeComments')
        .snapshots();
  }
}
