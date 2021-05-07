import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'trophies_view_model.dart';

class TrophiesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrophiesViewModel>.reactive(
      onModelReady: (TrophiesViewModel viewModel) =>
          viewModel.handleStartUpLogic(),
      builder: (BuildContext context, TrophiesViewModel viewModel, Widget _) {
        return Scaffold(
            body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text('Trophies'),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              StreamBuilder(
                stream: viewModel.getUserTrophies(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return snapshot.error;
                  }
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> trophyDocs = snapshot.data.docs;
                    trophyDocs.sort((a, b) {
                      int aInt =
                          a.get('trophyReceivedDate').microsecondsSinceEpoch;
                      int bInt =
                          b.get('trophyReceivedDate').microsecondsSinceEpoch;
                      return bInt.compareTo(aInt);
                    });

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.builder(
                        itemCount: trophyDocs.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          String trophyDescription = trophyDocs[index]
                                  ['trophyDescription'] ??
                              'No description';
                          return GestureDetector(
                            onTap: () {
                              if (!trophyDocs[index]['isNormalTrophy']) {
                                viewModel.pushTrophyView(
                                  title: trophyDocs[index]['title'],
                                  id: trophyDocs[index]['id'],
                                  previewLink: trophyDocs[index]['previewLink'],
                                  docId: trophyDocs[index].id,
                                  isNormalTrophy: trophyDocs[index]
                                      ['isNormalTrophy'],
                                  trophyChallengeDiscription: trophyDocs[index]
                                      ['trophyChallengeDiscription'],
                                  trophyChallengeImage: trophyDocs[index]
                                      ['trophyChallengeImage'],
                                  trophyChallengeName: trophyDocs[index]
                                      ['trophyChallengeName'],
                                  trophyChallengeRules: trophyDocs[index]
                                      ['trophyChallengeRules'],
                                  trophyDescription: trophyDocs[index]
                                      ['trophyDescription'],
                                  trophyReceivedDate: trophyDocs[index]
                                      ['trophyReceivedDate'],
                                  trophyTitle: trophyDocs[index]['trophyTitle'],
                                );
                              } else {
                                viewModel.pushTrophyView(
                                  title: null,
                                  id: null,
                                  previewLink: null,
                                  docId: trophyDocs[index].id,
                                  isNormalTrophy: trophyDocs[index]
                                      ['isNormalTrophy'],
                                  trophyChallengeDiscription: null,
                                  trophyChallengeImage: null,
                                  trophyChallengeName: null,
                                  trophyChallengeRules: null,
                                  trophyDescription: trophyDocs[index]
                                      ['trophyDescription'],
                                  trophyReceivedDate: trophyDocs[index]
                                      ['trophyReceivedDate'],
                                  trophyTitle: trophyDocs[index]['trophyTitle'],
                                );
                              }
                            },
                            child: Container(
                              height: 90,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Hero(
                                        tag: !trophyDocs[index]
                                                ['isNormalTrophy']
                                            ? trophyDocs[index]['id']
                                            : trophyDocs[index].id,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6.0),
                                          child: trophyDocs[index]
                                                  ['isNormalTrophy']
                                              ? Icon(
                                                  Icons.emoji_events,
                                                  size: 35,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )
                                              : Container(
                                                  height: 60,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        trophyDocs[index][
                                                            'trophyChallengeImage'],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 9,
                                          ),
                                          Text(
                                            trophyDocs[index]['trophyTitle'],
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            trophyDescription.length >= 30
                                                ? trophyDescription.substring(
                                                        0, 30) +
                                                    '..'
                                                : trophyDescription,
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ]))
          ],
        ));
      },
      viewModelBuilder: () => TrophiesViewModel(),
    );
  }
}
