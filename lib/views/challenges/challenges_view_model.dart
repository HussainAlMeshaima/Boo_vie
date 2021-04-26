import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ChallengesViewModel extends BaseViewModel {
  Logger log;

  ChallengesViewModel() {
    log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  StreamServices _streamServices = locator<StreamServices>();

  Future<DocumentSnapshot> getUserChallenges() {
    return _cloudFirestoreServices.getUserChallenges();
  }

  Stream<QuerySnapshot> getGlobalChallengesStream() {
    return _streamServices.getGlobalChallengesStream();
  }
}
