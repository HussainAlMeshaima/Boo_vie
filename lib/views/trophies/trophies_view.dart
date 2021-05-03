import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'trophies_view_model.dart';

class TrophiesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrophiesViewModel>.reactive(
      builder: (BuildContext context, TrophiesViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Trophies'),
          ),
          body: StreamBuilder(
            stream: viewModel.getUserTrophies(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return snapshot.error;
              }
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> trophyDocs = snapshot.data.docs;
                trophyDocs.sort((a, b) {
                  int aInt = a.get('trophyReceivedDate').microsecondsSinceEpoch;
                  int bInt = b.get('trophyReceivedDate').microsecondsSinceEpoch;
                  return aInt.compareTo(bInt);
                });
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: trophyDocs.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      Timestamp trophyReceivedDate = trophyDocs[index]
                              ['trophyReceivedDate'] ??
                          DateTime.now();
                      String trophyDescription = trophyDocs[index]
                              ['trophyDescription'] ??
                          'noDescription';
                      String trophyTitle =
                          trophyDocs[index]['trophyTitle'] ?? 'trophyTitle';
                      IconData icon = trophyDocs[index]['isNormalTrophy']
                          ? Icons.emoji_events
                          : Icons.auto_stories;
                      return GestureDetector(
                        onTap: () {
                          viewModel.pushTrophyView(
                              trophyDescription: trophyDescription,
                              trophyTitle: trophyTitle,
                              trophyReceivedDate: trophyReceivedDate);
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
                                    tag: 1,
                                    child: Icon(
                                      icon,
                                      size: 40,
                                      color: Theme.of(context).primaryColor,
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
                                        trophyTitle,
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
        );
      },
      viewModelBuilder: () => TrophiesViewModel(),
    );
  }
}
