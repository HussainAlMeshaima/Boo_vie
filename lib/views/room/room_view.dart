import 'package:boo_vi_app/widgets/smart_widgets/message_by_sender/message_by_sender_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/message_from_receiver/message_from_receiver_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'room_view_model.dart';

class RoomView extends StatelessWidget {
  final String docId;
  final String roomId;
  final String doorName;

  const RoomView(
      {Key key,
      @required this.roomId,
      @required this.doorName,
      @required this.docId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoomViewModel>.reactive(
      onModelReady: (RoomViewModel viewModel) => viewModel.handleStartUpLogic(
        roomId: roomId,
        doorName: doorName,
        docId: docId,
      ),
      builder: (BuildContext context, RoomViewModel viewModel, Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text(viewModel.doorName),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) {
                          viewModel.sendTheGivenMessageToAGivenRoom(
                              context: context);
                          FocusScope.of(context).unfocus();
                        },
                        controller: viewModel.messageController,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .color
                                    .withOpacity(.6)),
                            border: InputBorder.none),
                      ),
                    ),
                    FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 2,
                      onPressed: () {
                        viewModel.sendTheGivenMessageToAGivenRoom(
                            context: context);
                        FocusScope.of(context).unfocus();
                      },
                      child: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder(
                      stream: viewModel.getRoomMessages(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          List<QueryDocumentSnapshot> messagesDocs =
                              snapshot.data.docs;
                          messagesDocs.sort(
                            (a, b) {
                              int aInt = a
                                  .get('messageTimeStamp')
                                  .microsecondsSinceEpoch;
                              int bInt = b
                                  .get('messageTimeStamp')
                                  .microsecondsSinceEpoch;
                              return aInt.compareTo(bInt);
                            },
                          );
                          return ListView.builder(
                            itemCount: messagesDocs.length,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (messagesDocs[index]['messageUserEmail'] ==
                                  viewModel.currentUserEmail) {
                                return MessageBySenderWidget(
                                    text: messagesDocs[index]['messageString'],
                                    timestamp: messagesDocs[index]
                                        ['messageTimeStamp']);
                              }
                              return MessageFromReceiverWidget(
                                  otherUserImage: messagesDocs[index]
                                      ['userImage'],
                                  text: messagesDocs[index]['messageString'],
                                  timestamp: messagesDocs[index]
                                      ['messageTimeStamp']);
                            },
                          );
                        }
                        return Container(
                            height: MediaQuery.of(context).size.height / 1.4,
                            child: Center(child: CircularProgressIndicator()));
                      },
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ));
      },
      viewModelBuilder: () => RoomViewModel(),
    );
  }
}
