import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/streamServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class RoomViewModel extends BaseViewModel {
  Logger log;

  RoomViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  StreamServices _streamServices = locator<StreamServices>();

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Stream<QuerySnapshot> getRoomMessages() {
    return _streamServices.getRoomMessages(docId: _docId, roomId: _roomId);
  }

  Future<String> getCurrentUserEmail() async {
    return await _authenticationService.userEmail();
  }

  handleStartUpLogic({
    @required String roomId,
    @required String doorName,
    @required String docId,
  }) async {
    _roomId = roomId;
    _doorName = doorName;
    _docId = docId;
    _currentUserEmail = await getCurrentUserEmail();
  }

  String _roomId;
  String get roomId => _roomId;

  String _doorName;
  String get doorName => _doorName;

  String _docId;
  String get docId => _docId;

  String _currentUserEmail;
  String get currentUserEmail => _currentUserEmail;

  bool _isUserTryping = false;
  bool get isUserTryping => _isUserTryping;

  setIsUserTryping() {
    _isUserTryping = true;
  }

  setBackIsUserTryping() {
    _isUserTryping = false;
  }

  sendTheGivenMessageToAGivenRoom({@required BuildContext context}) async {
    _messageController.text.trim();

    if (_messageController.text.isNotEmpty) {
      await _cloudFirestoreServices.sendTheGivenMessageToAGivenRoom(
          messageString: _messageController.text,
          roomId: _roomId,
          docId: _docId);
      _messageController.clear();
    }
  }

  TextEditingController _messageController = TextEditingController(text: '');
  TextEditingController get messageController => _messageController;
}
