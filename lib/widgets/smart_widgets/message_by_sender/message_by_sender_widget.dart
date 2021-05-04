import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'message_by_sender_view_model.dart';

class MessageBySenderWidget extends StatelessWidget {
  final String text;
  final Timestamp timestamp;

  const MessageBySenderWidget(
      {Key key, @required this.text, @required this.timestamp})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageBySenderViewModel>.reactive(
      builder:
          (BuildContext context, MessageBySenderViewModel viewModel, Widget _) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, bottom: 5, top: 5),
          child: Align(
            alignment: Alignment.topRight,
            child: Card(
                color: Theme.of(context).primaryColor.withOpacity(.8),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 5, left: 12.0, right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('sdasdasdasdasdskdal;sdk'),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '20:18',
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
      viewModelBuilder: () => MessageBySenderViewModel(),
    );
  }
}
