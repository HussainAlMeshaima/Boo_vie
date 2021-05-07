import 'dart:ui';

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
                IconButton(
                  tooltip: 'Trophies',
                  icon: Icon(Icons.emoji_events),
                  onPressed: () {
                    viewModel.pushTrophiesView();
                  },
                ),
                IconButton(
                  tooltip: 'Compleated Challenges',
                  icon: Icon(Icons.history),
                  onPressed: () {
                    viewModel.pushCompletedChallengesView();
                  },
                )
              ],
              title:
                  Tooltip(message: 'Challenges tab', child: Text('Challenges')),
              bottom: TabBar(
                controller: viewModel.tabController,
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
              physics: BouncingScrollPhysics(),
              controller: viewModel.tabController,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                      stream: viewModel.getGlobalChallengesStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          List<QueryDocumentSnapshot> globalChallangesDocs =
                              snapshot.data.docs;
                          return ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  globalChallangesDocs.sort(
                                    (a, b) {
                                      int aInt = a.get('challengeLikeCounter');
                                      int bInt = b.get('challengeLikeCounter');
                                      return bInt.compareTo(aInt);
                                    },
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 3),
                                    child: GestureDetector(
                                      onTap: () {
                                        viewModel.pushGlobalChallengeView(
                                            challengeRules:
                                                globalChallangesDocs[index]
                                                    ['challengeRules'],
                                            trophiesMap: globalChallangesDocs[index]
                                                ['trophiesMap'],
                                            numberOfCommunitiesWhoHasThatChallangeCount:
                                                globalChallangesDocs[index][
                                                    'numberOfCommunitiesWhoHasThatChallangeCount'],
                                            numberOfCommentsCount:
                                                globalChallangesDocs[index]
                                                    ['numberOfCommentsCount'],
                                            trophiesCount: globalChallangesDocs[index]
                                                ['trophiesCount'],
                                            challengeDiscription:
                                                globalChallangesDocs[index]
                                                    ['challengeDiscription'],
                                            setToDate: globalChallangesDocs[index]
                                                ['setToDate'],
                                            numberOfPeopleWhoHasTheChallengeCount:
                                                globalChallangesDocs[index]
                                                    ['numberOfPeopleWhoHasThatChallengeCount'],
                                            challengeLikeCounter: globalChallangesDocs[index]['challengeLikeCounter'],
                                            challengeName: globalChallangesDocs[index]['challengeName'],
                                            bookTitle: globalChallangesDocs[index]['bookTitle'],
                                            bookId: globalChallangesDocs[index]['id'],
                                            previewLink: globalChallangesDocs[index]['previewLink'],
                                            challengeAuthors: globalChallangesDocs[index]['challengeAuthors'],
                                            image: globalChallangesDocs[index]['challengeImage'],
                                            challangeId: globalChallangesDocs[index].id);
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
                                                  globalChallangesDocs[index]
                                                      ['challengeImage']),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ),
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
                                                            globalChallangesDocs[
                                                                    index][
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
                                                                globalChallangesDocs[
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
                                                                globalChallangesDocs[
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
                                                                  globalChallangesDocs[
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
                                                                  globalChallangesDocs[
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
                                                                  globalChallangesDocs[
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
                          physics: BouncingScrollPhysics(),
                          children: [
                            // !UserGlobalChallenges
                            StreamBuilder(
                              stream: viewModel.getUserGlobalChallengesStream(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) return snapshot.error;

                                if (!snapshot.hasData ||
                                    snapshot.data.docs.length == 0) {
                                  return Container();
                                }
                                if (snapshot.hasData) {
                                  viewModel.sethasGlobalChallengesToTrue();
                                  List<QueryDocumentSnapshot>
                                      globalChallangesDocs = snapshot.data.docs;

                                  globalChallangesDocs.removeWhere(
                                      (challange) =>
                                          challange['isChallangeHidden'] ==
                                          true);

                                  globalChallangesDocs.sort(
                                    (a, b) {
                                      int aInt;
                                      int bInt;
                                      if (a.get('compleatedChallenge')) {
                                        aInt = 1;
                                      } else {
                                        aInt = 0;
                                      }

                                      if (b.get('compleatedChallenge')) {
                                        bInt = 1;
                                      } else {
                                        bInt = 0;
                                      }
                                      return aInt.compareTo(bInt);
                                    },
                                  );
                                  if (globalChallangesDocs.length == 0) {
                                    return Container();
                                  } else {
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
                                          itemCount:
                                              globalChallangesDocs.length,
                                          itemBuilder: (context, index) {
                                            int setToDate =
                                                globalChallangesDocs[index]
                                                        ['setToDate']
                                                    .toDate()
                                                    .difference(DateTime.now())
                                                    .inSeconds;

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 3),
                                              child: GestureDetector(
                                                onTap: () {
                                                  viewModel.pushUserGlobalChallengeView(
                                                      compleatedChallenge:
                                                          globalChallangesDocs[index][
                                                              'compleatedChallenge'],
                                                      challengeRules: globalChallangesDocs[index]
                                                          ['challengeRules'],
                                                      trophiesMap:
                                                          globalChallangesDocs[index]
                                                              ['trophiesMap'],
                                                      numberOfCommunitiesWhoHasThatChallangeCount:
                                                          globalChallangesDocs[index][
                                                              'numberOfCommunitiesWhoHasThatChallangeCount'],
                                                      numberOfCommentsCount:
                                                          globalChallangesDocs[index][
                                                              'numberOfCommentsCount'],
                                                      trophiesCount:
                                                          globalChallangesDocs[index]
                                                              ['trophiesCount'],
                                                      challengeDiscription: snapshot
                                                          .data
                                                          .docs[index]['challengeDiscription']
                                                          .replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), ''),
                                                      setToDate: globalChallangesDocs[index]['setToDate'],
                                                      numberOfPeopleWhoHasTheChallengeCount: globalChallangesDocs[index]['numberOfPeopleWhoHasThatChallengeCount'],
                                                      challengeLikeCounter: globalChallangesDocs[index]['challengeLikeCounter'],
                                                      challengeName: globalChallangesDocs[index]['challengeName'],
                                                      bookTitle: globalChallangesDocs[index]['bookTitle'],
                                                      bookId: globalChallangesDocs[index]['id'],
                                                      previewLink: globalChallangesDocs[index]['previewLink'],
                                                      challengeAuthors: globalChallangesDocs[index]['challengeAuthors'],
                                                      image: globalChallangesDocs[index]['challengeImage'],
                                                      challangeId: globalChallangesDocs[index].id);
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
                                                            globalChallangesDocs[
                                                                    index][
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
                                                                            0.0),
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  colorFilter: ColorFilter
                                                                      .mode(
                                                                          viewModel
                                                                              .whatColorIsThatChallange(
                                                                            setToDate:
                                                                                setToDate,
                                                                            challengeIsCompleated:
                                                                                globalChallangesDocs[index]['compleatedChallenge'],
                                                                          ),
                                                                          BlendMode
                                                                              .hardLight),
                                                                  image: NetworkImage(
                                                                      globalChallangesDocs[
                                                                              index]
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
                                                                          globalChallangesDocs[index]
                                                                              [
                                                                              'challengeName'],
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                          globalChallangesDocs[index]
                                                                              [
                                                                              'challengeAuthors'],
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(color: Colors.white),
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
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }
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

                                if (snapshot.hasData &&
                                    snapshot.data.docs.length != 0) {
                                  viewModel.setHasMyChallengesToTrue();
                                  List<QueryDocumentSnapshot>
                                      userChallangesDocs = snapshot.data.docs;
                                  userChallangesDocs.sort((a, b) {
                                    int aInt = a
                                        .get('setToDate')
                                        .microsecondsSinceEpoch;
                                    int bInt = b
                                        .get('setToDate')
                                        .microsecondsSinceEpoch;
                                    return bInt.compareTo(aInt);
                                  });
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
                                        itemCount: userChallangesDocs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            // onTap: () => viewModel
                                            //     .pushMyChallangesView(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 3),
                                              child: Container(
                                                height: 130,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  child: Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 12),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () => viewModel
                                                                .pushBookView(
                                                              authors:
                                                                  userChallangesDocs[
                                                                          index]
                                                                      [
                                                                      'authors'],
                                                              image: userChallangesDocs[
                                                                      index]
                                                                  ['bookImage'],
                                                              id: userChallangesDocs[
                                                                  index]['id'],
                                                              bookTitle:
                                                                  userChallangesDocs[
                                                                          index]
                                                                      ['title'],
                                                              previewLink:
                                                                  userChallangesDocs[
                                                                          index]
                                                                      [
                                                                      'previewLink'],
                                                            ),
                                                            child: Container(
                                                              height: 110,
                                                              width: 71,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(
                                                                          userChallangesDocs[index]
                                                                              [
                                                                              'bookImage']))),
                                                            ),
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
                                                                  userChallangesDocs[
                                                                          index]
                                                                      ['title'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Text(
                                                                  userChallangesDocs[
                                                                              index]
                                                                          [
                                                                          'authors'] ??
                                                                      'No Authors',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
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
                                                                              viewModel.convertTheGivenTimestampToString(snapshot.data.docs[index]['setToDate']),
                                                                              style: TextStyle(fontSize: 22, wordSpacing: 5, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 15,
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
                                                                          List<double>
                                                                              emojisList =
                                                                              [];
                                                                          for (DocumentSnapshot item in snapshot
                                                                              .data
                                                                              .docs) {
                                                                            emojisList.add(item.data()['userReviewEmojiRating']);
                                                                          }
                                                                          if (emojisList.length !=
                                                                              0) {
                                                                            double
                                                                                avg =
                                                                                emojisList.reduce((a, b) => a + b);

                                                                            avg =
                                                                                (avg / emojisList.length);

                                                                            int totlaAvg =
                                                                                avg.toInt();
                                                                            String
                                                                                emoji;

                                                                            switch (totlaAvg) {
                                                                              case 0:
                                                                                emoji = '😡';
                                                                                break;

                                                                              case 1:
                                                                                emoji = '🤢';
                                                                                break;

                                                                              case 2:
                                                                                emoji = '😟';
                                                                                break;

                                                                              case 3:
                                                                                emoji = '😧';
                                                                                break;

                                                                              case 4:
                                                                                emoji = '😨';
                                                                                break;

                                                                              case 5:
                                                                                emoji = '😰';
                                                                                break;

                                                                              case 6:
                                                                                emoji = '😓';
                                                                                break;

                                                                              case 7:
                                                                                emoji = '😫';
                                                                                break;

                                                                              case 8:
                                                                                emoji = '😭';
                                                                                break;

                                                                              case 9:
                                                                                emoji = '😦';
                                                                                break;

                                                                              case 10:
                                                                                emoji = '😮';
                                                                                break;

                                                                              case 11:
                                                                                emoji = '😃';
                                                                                break;

                                                                              case 12:
                                                                                emoji = '😁';
                                                                                break;

                                                                              case 13:
                                                                                emoji = '🥰';
                                                                                break;

                                                                              case 14:
                                                                                emoji = '😍';
                                                                                break;

                                                                              default:
                                                                                emoji = '🥱';

                                                                                break;
                                                                            }

                                                                            return Tooltip(
                                                                              message: 'The avarage rating for this book is $emoji',
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    child: Text(
                                                                                      emoji,
                                                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Text(
                                                                                    'BooVi',
                                                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }
                                                                          return Tooltip(
                                                                            message:
                                                                                'Looks like no one reviewed this book yet 🥱',
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  child: Text(
                                                                                    '🥱',
                                                                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Text(
                                                                                  'BooVi',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }

                                                                        return Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                CircularProgressIndicator(),
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
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  );
                                }

                                if (!snapshot.hasData ||
                                    viewModel.hasGlobalChallenges == false &&
                                        viewModel.hasGlobalChallenges ==
                                            false) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.3,
                                    child: Center(
                                      child:
                                          Text('You have no challanges yet 😭'),
                                    ),
                                  );
                                }
                                if (snapshot.data.docs.length == 0 &&
                                    viewModel.hasGlobalChallenges == true)
                                  return Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.3,
                                    child: Center(
                                      child:
                                          Text('You have no challanges yet 😭'),
                                    ),
                                  );

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
                    },
                  ),
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
