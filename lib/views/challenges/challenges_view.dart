import 'package:boo_vi_app/widgets/smart_widgets/global_challenges/global_challenges_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'challenges_view_model.dart';

class ChallengesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChallengesViewModel>.reactive(
      builder: (BuildContext context, ChallengesViewModel viewModel, Widget _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title:
                  Tooltip(message: 'Challenges tab', child: Text('Challenges')),
              bottom: TabBar(
                tabs: [
                  Tooltip(
                      message: 'Global challenges tab',
                      child: Tab(icon: Text('Global challenges'))),
                  Tooltip(
                      message: 'My challenges tab',
                      child: Tab(icon: Text('My challenges'))),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                StreamBuilder(
                    stream: viewModel.getGlobalChallengesStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: snapshot.data.docs.map<Widget>(
                              (DocumentSnapshot document) {
                                return GlobalChallengesWidget(
                                  arrowDownCount:
                                      document.data()['arrowDownCount'],
                                  arrowUpCount: document.data()['arrowUpCount'],
                                  bookId: document.data()['bookId'],
                                  bookAuthor: document.data()['bookAuthor'],
                                  bookImage: document.data()['bookImage'],
                                  bookTitle: document.data()['bookTitle'],
                                  challengeDate:
                                      document.data()['challengeDate'].toDate(),
                                  challengeDisc:
                                      document.data()['challengeDisc'],
                                  challengeTitle:
                                      document.data()['challengeTitle'],
                                  trophyCount: document.data()['trophyCount'],
                                  trophyDisc: document.data()['trophyDisc'],
                                  numberOfPeopleWhoHasCompletedThatChallenge:
                                      document.data()[
                                          'numberOfPeopleWhoHasCompletedThatChallenge'],
                                  numberOfPeopleWhoHasNotCompletedThatChallenge:
                                      document.data()[
                                          'numberOfPeopleWhoHasNotCompletedThatChallenge'],
                                  trophyIcon: document.data()['trophyIcon'],
                                  trophyImage: document.data()['trophyImage'],
                                  trophyName: document.data()['trophyName'],
                                );
                              },
                            ).toList());
                      }
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }),
                FutureBuilder(
                    future: viewModel.getUserChallenges(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) return snapshot.error;

                      if (snapshot.hasData) {
                        return Text(
                            snapshot.data.data()['challenges'].toString());
                      }
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    })
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ChallengesViewModel(),
    );
  }
}
