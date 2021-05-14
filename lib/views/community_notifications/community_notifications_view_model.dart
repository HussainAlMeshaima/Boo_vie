import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class CommunityNotificationsViewModel extends BaseViewModel {
  Logger log;

  CommunityNotificationsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();
  StreamServices _streamServices = locator<StreamServices>();

  Stream<QuerySnapshot> getCommunityNotifications() {
    return _streamServices.getCommunityNotifications(docId: _docId);
  }

  void addAMemberToAGivenMemeberToComunity({
    @required String displayedName,
    @required String memberEmail,
    @required String userImage,
  }) {
    _cloudFirestoreServices.addAMemberToAGivenMemeberToComunity(
      displayedName: displayedName,
      memberEmail: memberEmail,
      docId: _docId,
      userImage: userImage,
    );
  }

  String _docId;
  String get docId => _docId;

  handleStartUpLogic({@required String docId}) {
    _docId = docId;
  }

  void deleteUserMessage({@required String id}) {
    _cloudFirestoreServices.deleteUserMessage(id: id, docId: _docId);
  }
}
