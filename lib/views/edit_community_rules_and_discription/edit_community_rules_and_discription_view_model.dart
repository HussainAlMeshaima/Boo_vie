import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class EditCommunityRulesAndDiscriptionViewModel extends BaseViewModel {
  Logger log;

  EditCommunityRulesAndDiscriptionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  StreamServices _streamServices = locator<StreamServices>();
  Stream<QuerySnapshot> getCommunityInformation() {
    return _streamServices.getCommunityInformation(communityId: _docId);
  }

  String _docId;
  String get docId => _docId;

  handleStartUpLogic({@required String docId}) {
    _docId = docId;
  }
}
