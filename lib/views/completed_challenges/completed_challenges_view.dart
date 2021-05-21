import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'completed_challenges_view_model.dart';

class CompletedChallengesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompletedChallengesViewModel>.reactive(
      builder: (BuildContext context, CompletedChallengesViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Completed Challanges'),
          ),
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: StreamBuilder(
                      stream: viewModel.getCompletedChallengesStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.docs.isEmpty) {
                            return Center(
                              child: Text('No completed challenges yet 😭'),
                            );
                          }
                          if (snapshot.data.docs.isNotEmpty) {
                            List<QueryDocumentSnapshot> globalChallangesDocs =
                                snapshot.data.docs;

                            globalChallangesDocs.sort(
                              (a, b) {
                                int aInt = a
                                    .get('completedDate')
                                    .microsecondsSinceEpoch;
                                int bInt = b
                                    .get('completedDate')
                                    .microsecondsSinceEpoch;
                                return aInt.compareTo(bInt);
                              },
                            );
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: globalChallangesDocs.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    viewModel.compleatedChallangeView(
                                      challengeId: globalChallangesDocs[index]
                                          ['challengeId'],
                                      bookId: globalChallangesDocs[index]
                                          ['bookId'],
                                      bookTitle: globalChallangesDocs[index]
                                          ['bookTitle'],
                                      challengeAuthorName:
                                          globalChallangesDocs[index]
                                              ['challengeAuthorName'],
                                      challengeDiscription:
                                          globalChallangesDocs[index]
                                              ['challengeDiscription'],
                                      challengeImage:
                                          globalChallangesDocs[index]
                                              ['challengeImage'],
                                      challengeRules:
                                          globalChallangesDocs[index]
                                              ['challengeRules'],
                                      completedDate: globalChallangesDocs[index]
                                          ['completedDate'],
                                      previewLink: globalChallangesDocs[index]
                                          ['previewLink'],
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height: 210,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              globalChallangesDocs[index]
                                                  ['challengeImage']),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            ImageFiltered(
                                              imageFilter: ImageFilter.blur(
                                                sigmaX: 5,
                                                sigmaY: 5,
                                                tileMode: TileMode.repeated,
                                              ),
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.green,
                                                            BlendMode
                                                                .hardLight),
                                                    image: NetworkImage(
                                                        globalChallangesDocs[
                                                                index]
                                                            ['challengeImage']),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    bottom: 5,
                                                    right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            globalChallangesDocs[
                                                                    index][
                                                                'challengeName'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            globalChallangesDocs[
                                                                    index][
                                                                'challengeAuthorName'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              )),
        );
      },
      viewModelBuilder: () => CompletedChallengesViewModel(),
    );
  }
}
