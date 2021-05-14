import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class AddARoomViewModel extends BaseViewModel {
  Logger log;

  AddARoomViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  createARoomInThatComunity() {
    _cloudFirestoreServices.createARoomInThatComunity(
        docId: _docId, roomName: _roomController.text);
  }

  String getControlerOnCange(char) {
    String word = _roomController.text + char;
    notifyListeners();
    return word;
  }

  TextEditingController _roomController = TextEditingController(text: '');
  TextEditingController get roomController => _roomController;

  handleStartUpLogic({@required String docId}) {
    _docId = docId;
  }

  String _docId;
  String get docId => _docId;
}
