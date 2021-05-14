import 'package:boo_vi_app/widgets/smart_widgets/comunity_cards/comunity_cards_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/message_by_sender/message_by_sender_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/message_from_receiver/message_from_receiver_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comunintys_view_model.dart';

class ComunintysView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunintysViewModel>.reactive(
      builder: (BuildContext context, ComunintysViewModel viewModel, Widget _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  return showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: [
                            ListTile(
                              title: Text(
                                'Create What ?',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 5),
                              child: ListTile(
                                leading: Icon(
                                  Icons.group_work,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text('Create a Comuninty'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 5),
                              child: ListTile(
                                leading: Icon(
                                  Icons.sms,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text('Create a conversation'),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      });
                },
                child: Icon(Icons.add),
              ),
              appBar: AppBar(
                title: Tooltip(
                    message: 'Comunintys tab', child: Text('Comunintys')),
                bottom: TabBar(
                  tabs: [
                    Tooltip(
                        message: 'Global communities tab',
                        child: Tab(
                            icon: Text(
                          'Global communities',
                          textAlign: TextAlign.center,
                        ))),
                    Tooltip(
                        message: 'My communities tab',
                        child: Tab(
                            icon: Text(
                          'My communities',
                          textAlign: TextAlign.center,
                        ))),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  // ! Global Comunintys

                  StreamBuilder(
                    stream: viewModel.getCommunities(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ComunityCardsWidget(
                              member1Image: snapshot.data.docs[index]
                                  ['member1Image'],
                              member2Image: snapshot.data.docs[index]
                                  ['member2Image'],
                              numberOfChallenges: snapshot.data.docs[index]
                                  ['numberOfChallenges'],
                              docId: snapshot.data.docs[index].id,
                              communityImage: snapshot.data.docs[index]
                                  ['communityImage'],
                              communityAdminImage: snapshot.data.docs[index]
                                  ['communityAdminImage'],
                              onTap: () {
                                viewModel.pushComunintyInformationView(
                                  communityAdminEmail: snapshot.data.docs[index]
                                      ['communityAdminEmail'],
                                  comunityName: snapshot.data.docs[index]
                                      ['comunityName'],
                                  communityAdminName: snapshot.data.docs[index]
                                      ['communityAdminName'],
                                  communityCreatedon: snapshot.data.docs[index]
                                      ['communityCreatedon'],
                                  communityAdminImage: snapshot.data.docs[index]
                                      ['communityAdminImage'],
                                  docId: snapshot.data.docs[index].id,
                                  communityImage: snapshot.data.docs[index]
                                      ['communityImage'],
                                );
                              },
                              numberOfLikes: snapshot.data.docs[index]
                                  ['numberOfLikes'],
                              comunityName: snapshot.data.docs[index]
                                  ['comunityName'],
                              numberOfMembers: snapshot.data.docs[index]
                                  ['numberOfMembers'],
                            );
                          },
                        );
                      }
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),

                  // ! My Comunintys
                  Container(
                    child: ListView(
                      children: [],
                    ),
                  ),
                ],
              )),
        );
      },
      viewModelBuilder: () => ComunintysViewModel(),
    );
  }
}
