import 'package:boo_vi_app/widgets/smart_widgets/notification_card/notification_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'community_notifications_view_model.dart';

class CommunityNotificationsView extends StatelessWidget {
  final String docId;

  const CommunityNotificationsView({Key key, @required this.docId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityNotificationsViewModel>.reactive(
      onModelReady: (CommunityNotificationsViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        docId: docId,
      ),
      builder: (BuildContext context, CommunityNotificationsViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Notifications'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: viewModel.getCommunityNotifications(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.isEmpty) {
                        return Container(
                          height: 75,
                          child: Card(
                            child:
                                Center(child: Text('No new notifications 😭')),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        );
                      }
                      if (snapshot.data.docs.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return NotificationCardWidget(
                                onPressed: () {
                                  viewModel.addAMemberToAGivenMemeberToComunity(
                                    displayedName: snapshot.data.docs[index]
                                        ['displayedName'],
                                    userImage: snapshot.data.docs[index]
                                        ['userImage'],
                                    memberEmail: snapshot.data.docs[index]
                                        ['memberEmail'],
                                  );

                                  viewModel.deleteUserMessage(
                                      id: snapshot.data.docs[index].id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                              snapshot.data.docs[index]
                                                      ['displayedName'] +
                                                  ' has been added')));
                                },
                                displayedName: snapshot.data.docs[index]
                                    ['displayedName'],
                                userImage: snapshot.data.docs[index]
                                    ['userImage'],
                                onLongPress: () {
                                  viewModel.deleteUserMessage(
                                      id: snapshot.data.docs[index].id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                              snapshot.data.docs[index]
                                                      ['displayedName'] +
                                                  ' has been removed')));
                                },
                                memberEmail: snapshot.data.docs[index]
                                    ['memberEmail'],
                              );
                            });
                      }
                    }
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => CommunityNotificationsViewModel(),
    );
  }
}
