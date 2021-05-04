import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class CompletedChallengesViewModel extends BaseViewModel {
  Logger log;

  CompletedChallengesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  Stream<QuerySnapshot> getCompletedChallengesStream() async* {
    yield* _cloudFirestoreServices.getCompletedChallengesStream();
  }
}
