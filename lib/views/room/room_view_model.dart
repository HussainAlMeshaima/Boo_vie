import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class RoomViewModel extends BaseViewModel {
  Logger log;

  RoomViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  Stream<QuerySnapshot> getThatPrivateChatWithThatOtherUser() async* {
    yield* _cloudFirestoreServices.getThatPrivateChatWithThatOtherUser(
        otherUser: _otherUserEmailWhichIsAlsoADoc);
  }

  handleStartUpLogic(String otherUserWhichIsAlsoADoc) {
    _otherUserEmailWhichIsAlsoADoc = otherUserEmailWhichIsAlsoADoc;
  }

  String _otherUserEmailWhichIsAlsoADoc;
  String get otherUserEmailWhichIsAlsoADoc => _otherUserEmailWhichIsAlsoADoc;
}
