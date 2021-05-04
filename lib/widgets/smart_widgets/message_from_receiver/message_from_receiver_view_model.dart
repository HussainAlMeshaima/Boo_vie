import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:intl/intl.dart';

class MessageFromReceiverViewModel extends BaseViewModel {
  Logger log;

  MessageFromReceiverViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  String convertTheGivenTimestampToString(Timestamp timestamp) {
    DateTime otherDate = timestamp.toDate();

    var time = DateFormat.jm().format(otherDate);

    return (time);
  }
}
