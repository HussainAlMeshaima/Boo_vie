import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'challenges_view_model.dart';

class ChallengesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChallengesViewModel>.reactive(
      onModelReady: (ChallengesViewModel viewModel) =>
          viewModel.handleStartUpLogic(),
      builder: (BuildContext context, ChallengesViewModel viewModel, Widget _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(icon: Icon(Icons.history), onPressed: () {})
              ],
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
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                      stream: viewModel.getGlobalChallengesStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 3),
                                    child: GestureDetector(
                                      onTap: () {
                                        viewModel.pushGlobalChallengeView(
                                            challengeRules: snapshot.data.docs[index]
                                                ['challengeRules'],
                                            trophiesMap: snapshot.data.docs[index]
                                                ['trophiesMap'],
                                            numberOfCommunitiesWhoHasThatChallangeCount:
                                                snapshot.data.docs[index][
                                                    'numberOfCommunitiesWhoHasThatChallangeCount'],
                                            numberOfCommentsCount: snapshot.data.docs[index]
                                                ['numberOfCommentsCount'],
                                            trophiesCount: snapshot.data.docs[index]
                                                ['trophiesCount'],
                                            challengeDiscription: snapshot.data.docs[index]
                                                ['challengeDiscription'],
                                            setToDate: snapshot.data.docs[index]
                                                ['setToDate'],
                                            numberOfPeopleWhoHasTheChallengeCount:
                                                snapshot.data.docs[index]['numberOfPeopleWhoHasThatChallengeCount'],
                                            challengeLikeCounter: snapshot.data.docs[index]['challengeLikeCounter'],
                                            challengeName: snapshot.data.docs[index]['challengeName'],
                                            bookTitle: snapshot.data.docs[index]['bookTitle'],
                                            bookId: snapshot.data.docs[index]['id'],
                                            previewLink: snapshot.data.docs[index]['previewLink'],
                                            challengeAuthors: snapshot.data.docs[index]['challengeAuthors'],
                                            image: snapshot.data.docs[index]['challengeImage'],
                                            challangeId: snapshot.data.docs[index].id);
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Container(
                                          height: 210,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  snapshot.data.docs[index]
                                                      ['challengeImage']),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
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
                                                              15.0),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors.black45,
                                                                BlendMode
                                                                    .darken),
                                                        image: NetworkImage(
                                                            snapshot.data
                                                                    .docs[index]
                                                                [
                                                                'challengeImage']),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 50,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                snapshot.data
                                                                            .docs[
                                                                        index][
                                                                    'challengeName'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                snapshot.data
                                                                            .docs[
                                                                        index][
                                                                    'challengeAuthors'],
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
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .people,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white),
                                                                Text(
                                                                  snapshot
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'numberOfPeopleWhoHasThatChallengeCount']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white),
                                                                Text(
                                                                  snapshot
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'challengeLikeCounter']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Icon(Icons.sms,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white),
                                                                Text(
                                                                  snapshot
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'numberOfCommentsCount']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 15,
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
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          );
                        }
                        return Center(
                          child: Container(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                      future: viewModel.getUserChallenges(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) return snapshot.error;

                        if (snapshot.hasData) {
                          return ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: [
                              // !UserGlobalChallenges
                              StreamBuilder(
                                stream:
                                    viewModel.getUserGlobalChallengesStream(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) return snapshot.error;

                                  if (!snapshot.hasData ||
                                      snapshot.data.docs.length == 0) {
                                    return Container();
                                  }
                                  if (snapshot.hasData) {
                                    return ListView(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      children: [
                                        SizedBox(
                                          height: 12,
                                        ),
                                        ListTile(
                                          title: Text('My Global Challenges'),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 3),
                                              child: GestureDetector(
                                                onTap: () {
                                                  viewModel.pushUserGlobalChallengeView(
                                                      challengeRules: snapshot.data.docs[index]
                                                          ['challengeRules'],
                                                      trophiesMap: snapshot.data.docs[index]
                                                          ['trophiesMap'],
                                                      numberOfCommunitiesWhoHasThatChallangeCount:
                                                          snapshot.data.docs[index][
                                                              'numberOfCommunitiesWhoHasThatChallangeCount'],
                                                      numberOfCommentsCount:
                                                          snapshot.data.docs[index][
                                                              'numberOfCommentsCount'],
                                                      trophiesCount: snapshot.data.docs[index]
                                                          ['trophiesCount'],
                                                      challengeDiscription: snapshot.data.docs[index]
                                                          ['challengeDiscription'],
                                                      setToDate: snapshot.data.docs[index]['setToDate'],
                                                      numberOfPeopleWhoHasTheChallengeCount: snapshot.data.docs[index]['numberOfPeopleWhoHasThatChallengeCount'],
                                                      challengeLikeCounter: snapshot.data.docs[index]['challengeLikeCounter'],
                                                      challengeName: snapshot.data.docs[index]['challengeName'],
                                                      bookTitle: snapshot.data.docs[index]['bookTitle'],
                                                      bookId: snapshot.data.docs[index]['id'],
                                                      previewLink: snapshot.data.docs[index]['previewLink'],
                                                      challengeAuthors: snapshot.data.docs[index]['challengeAuthors'],
                                                      image: snapshot.data.docs[index]['challengeImage'],
                                                      challangeId: snapshot.data.docs[index].id);
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  child: Container(
                                                    height: 210,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            snapshot.data
                                                                    .docs[index]
                                                                [
                                                                'challengeImage']),
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                      child: Stack(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        children: [
                                                          ImageFiltered(
                                                            imageFilter:
                                                                ImageFilter
                                                                    .blur(
                                                              sigmaX: 5,
                                                              sigmaY: 5,
                                                              tileMode: TileMode
                                                                  .repeated,
                                                            ),
                                                            child: Container(
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  colorFilter: ColorFilter.mode(
                                                                      Colors
                                                                          .black45,
                                                                      BlendMode
                                                                          .darken),
                                                                  image: NetworkImage(snapshot
                                                                          .data
                                                                          .docs[index]
                                                                      [
                                                                      'challengeImage']),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      bottom: 5,
                                                                      right:
                                                                          10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          snapshot
                                                                              .data
                                                                              .docs[index]['challengeName'],
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                          snapshot
                                                                              .data
                                                                              .docs[index]['challengeAuthors'],
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .timer,
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }

                                  return ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              // ! MyChallenges
                              StreamBuilder(
                                stream: viewModel.getMyChallengesStream(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) return snapshot.error;

                                  if (!snapshot.hasData) {
                                    return Container();
                                  }
                                  if (snapshot.hasData) {
                                    return ListView(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      children: [
                                        SizedBox(
                                          height: 12,
                                        ),
                                        ListTile(
                                          title: Text('My Challenges'),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 3),
                                                child: Container(
                                                  height: 130,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 12,
                                                                vertical: 12),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              height: 100,
                                                              width: 60,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(
                                                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTXWoEuWuNNrEQ6tGRTNzdhBt6-eLBRiphJgKutC8r4pTFGJ_trpYjNDXMR0DM79VDsSo&usqp=CAU'))),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Container(
                                                              width: 210,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Cultural Studies Goes to School',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            19,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Text(
                                                                    'David Buckingham',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            47,
                                                                        width:
                                                                            155,
                                                                        decoration: BoxDecoration(
                                                                            color: Theme.of(context).brightness == Brightness.dark
                                                                                ? Color(0xff262626)
                                                                                : Color(0xffE8E8E8),
                                                                            borderRadius: BorderRadius.circular(7)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                ',',
                                                                                style: TextStyle(fontSize: 22),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      StreamBuilder(
                                                                        stream: viewModel.getThatBookEmoji(snapshot
                                                                            .data
                                                                            .docs[index]['id']),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            return Text(
                                                                              '😋',
                                                                              style: TextStyle(fontSize: 22),
                                                                            );
                                                                          }

                                                                          return Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                20,
                                                                            child:
                                                                                Center(
                                                                              child: CircularProgressIndicator(),
                                                                            ),
                                                                          );
                                                                        },
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                          },
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    );
                                  }

                                  return ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          );
                        }
                        return Center(
                          child: Container(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ChallengesViewModel(),
    );
  }
}
