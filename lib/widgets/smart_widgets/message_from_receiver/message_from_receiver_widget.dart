import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'message_from_receiver_view_model.dart';

class MessageFromReceiverWidget extends StatelessWidget {
  final String text;
  final Timestamp timestamp;

  const MessageFromReceiverWidget(
      {Key key, @required this.text, @required this.timestamp})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageFromReceiverViewModel>.reactive(
      builder: (BuildContext context, MessageFromReceiverViewModel viewModel,
          Widget _) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, bottom: 5, top: 5),
          child: Align(
            alignment: Alignment.topLeft,
            child: Card(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 5, left: 12.0, right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    viewModel.convertTheGivenTimestampToString(timestamp),
                    style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.4)),
                  ),
                ],
              ),
            )),
          ),
        );
      },
      viewModelBuilder: () => MessageFromReceiverViewModel(),
    );
  }
}
