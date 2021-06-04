import 'dart:ui';
import 'dart:math' as math;
import 'package:intl/intl.dart';

import 'package:boo_vi_app/widgets/smart_widgets/add_a_room/add_a_room_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/door_type_1/door_type_1_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/door_type_2/door_type_2_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comuninty_information_view_model.dart';

class ComunintyInformationView extends StatelessWidget {
  final String docId;
  final String comunityName;
  final String communityImage;
  final String communityAdminImage;
  final String communityAdminName;
  final Timestamp communityCreatedon;
  final String communityAdminEmail;
  final String currentUserEmail;

  const ComunintyInformationView(
      {Key key,
      @required this.docId,
      @required this.communityImage,
      @required this.communityAdminImage,
      @required this.communityAdminName,
      @required this.communityCreatedon,
      @required this.comunityName,
      @required this.communityAdminEmail,
      @required this.currentUserEmail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunintyInformationViewModel>.reactive(
      onModelReady: (ComunintyInformationViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        docId: docId,
        communityAdminImage: communityAdminImage,
        communityAdminName: communityAdminName,
        communityCreatedon: communityCreatedon,
        comunityName: comunityName,
        communityImage: communityImage,
        communityAdminEmail: communityAdminEmail,
        currentUserEmail: currentUserEmail,
      ),
      builder: (BuildContext context, ComunintyInformationViewModel viewModel,
          Widget _) {
        return Scaffold(
            floatingActionButton: viewModel.currentUserEmail ==
                    viewModel.communityAdminEmail
                ? FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: [
                                ListTile(
                                  title: Text(
                                    'Add what ?',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 5),
                                  child: ListTile(
                                    leading: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Icon(Icons.sensor_door,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    title: Text('Add a room'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      return showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return AddARoomWidget(
                                              docId: docId,
                                            );
                                          });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            );
                          });
                    },
                    child: Icon(Icons.add),
                  )
                : Container(),
            body: CustomScrollView(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  title: Text('Comuninty information'),
                  pinned: true,
                  floating: false,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {
                          viewModel.pushCommunityNotificationsView();
                        })
                  ],
                  expandedHeight: 300.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(viewModel.communityImage)),
                      ),
                      child: Column(
                        children: [
                          Spacer(),
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                height: 60,
                                child: ClipRRect(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: new ColorFilter.mode(
                                            Colors.black.withOpacity(0.3),
                                            BlendMode.dstATop),
                                        image: NetworkImage(
                                          viewModel.communityImage,
                                        ),
                                      ),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 7,
                                          sigmaY: 7,
                                          tileMode: TileMode.clamp),
                                      child: Container(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black.withOpacity(0.4)
                                            : Colors.white.withOpacity(0.4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 100,
                                child: Container(
                                  width: 250,
                                  child: Text(
                                    viewModel.comunityName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Text(
                                    'Created on ' +
                                        DateFormat.yMd()
                                            .format(viewModel.communityCreatedon
                                                .toDate())
                                            .toString(),
                                    style: TextStyle(fontSize: 8),
                                  )),
                              Positioned(
                                left: 20,
                                top: -27,
                                child: Hero(
                                  tag: viewModel.docId,
                                  child: GestureDetector(
                                    onTap: () {
                                      viewModel
                                          .pushUserReviewToProfileAdminView();
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(viewModel
                                                  .communityAdminImage))),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 40,
                      ),
                      OutlinedButtonWidget(
                        text: 'Send request',
                        message:
                            'Send a request to join message for the admin of the community',
                        onPressed: () {
                          viewModel.sendARequestToAGivenComunityToJoin();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('A request has been has sent')));
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                        child: Row(
                          children: [
                            Tooltip(
                              message: 'About Comunity',
                              child: Text(
                                'About Comunity',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 20, right: 20, bottom: 10),
                        child: Container(
                          height: 80,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: StreamBuilder(
                                stream: viewModel.getCommunityInformation(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0,
                                          right: 22,
                                          left: 12.0,
                                          bottom: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Tooltip(
                                            message: 'Number of members are ' +
                                                snapshot.data
                                                    .docs[0]['numberOfMembers']
                                                    .toString(),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.people),
                                                Text(
                                                  snapshot
                                                      .data
                                                      .docs[0]
                                                          ['numberOfMembers']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: VerticalDivider(
                                              thickness: 1.2,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          Tooltip(
                                            message: 'Number of likes are ' +
                                                snapshot.data
                                                    .docs[0]['numberOfLikes']
                                                    .toString(),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.favorite),
                                                Text(
                                                  snapshot.data
                                                      .docs[0]['numberOfLikes']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: VerticalDivider(
                                              thickness: 1.2,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          Tooltip(
                                            message:
                                                'Total number of challenges are ' +
                                                    snapshot
                                                        .data
                                                        .docs[0][
                                                            'numberOfChallenges']
                                                        .toString(),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.timer),
                                                Text(
                                                  snapshot
                                                      .data
                                                      .docs[0]
                                                          ['numberOfChallenges']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                              )),
                        ),
                      ),
                    ],
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                        child: Row(
                          children: [
                            Tooltip(
                              message: 'Comunity rules',
                              child: Text(
                                'Comunity rules',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Spacer(),
                            viewModel.currentUserEmail ==
                                    viewModel.communityAdminEmail
                                ? GestureDetector(
                                    onTap: () {
                                      viewModel
                                          .pushEditCommunityRulesAndDiscriptionView();
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: StreamBuilder(
                              stream: viewModel.getCommunityInformation(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0,
                                          top: 12,
                                          right: 4,
                                          bottom: 10),
                                      child: snapshot.data.docs[0]['rules'] !=
                                                  null ||
                                              snapshot.data.docs[0]['rules']
                                                      .length >
                                                  0
                                          ? Tooltip(
                                              message: 'Comunity Rules are: ' +
                                                  snapshot.data.docs[0]['rules']
                                                      .join(', '),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  itemCount: snapshot.data
                                                      .docs[0]['rules'].length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(
                                                          12.0,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 10,
                                                              height: 10,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 7,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                snapshot
                                                                    .data
                                                                    .docs[0][
                                                                        'rules']
                                                                        [index]
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )),
                                              ),
                                            )
                                          : Tooltip(
                                              message: 'Rules are not set 😄',
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 50,
                                                  child: Center(
                                                    child: Text(
                                                        'Rules are not set 😄'),
                                                  ),
                                                ),
                                              ),
                                            ));
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
                    ],
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                        child: Row(
                          children: [
                            Tooltip(
                              message: 'Comunity description',
                              child: Text(
                                'Comunity description',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Spacer(),
                            viewModel.currentUserEmail ==
                                    viewModel.communityAdminEmail
                                ? GestureDetector(
                                    onTap: () {
                                      viewModel
                                          .pushEditCommunityRulesAndDiscriptionView();
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 0),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: StreamBuilder(
                              stream: viewModel.getCommunityInformation(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.docs[0]
                                          ['comunityDescription'] !=
                                      null)
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0,
                                          top: 12,
                                          right: 4,
                                          bottom: 10),
                                      child: Tooltip(
                                        message: snapshot.data.docs[0]
                                            ['comunityDescription'],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Text(snapshot.data.docs[0]
                                                ['comunityDescription']),
                                          ),
                                        ),
                                      ),
                                    );

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0,
                                        top: 12,
                                        right: 4,
                                        bottom: 10),
                                    child: Tooltip(
                                      message:
                                          'No discription for this comunity 😄',
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text(
                                              'No discription for this comunity 😄'),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
                    ],
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                        child: Row(
                          children: [
                            Tooltip(
                              message: 'Comunity Members',
                              child: Text(
                                'Comunity Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Spacer(),
                            Tooltip(
                              message: 'More comunity members',
                              child: GestureDetector(
                                onTap: () {
                                  viewModel.pushComunityMembersView();
                                },
                                child: Icon(Icons.arrow_forward,
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder(
                        stream: viewModel.getCommunityMembers(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.isNotEmpty) {
                              List<QueryDocumentSnapshot> membersDocs =
                                  snapshot.data.docs;
                              membersDocs.sort(
                                (a, b) {
                                  int aInt = a
                                      .get('joinedDate')
                                      .microsecondsSinceEpoch;
                                  int bInt = b
                                      .get('joinedDate')
                                      .microsecondsSinceEpoch;
                                  return aInt.compareTo(bInt);
                                },
                              );
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                child: ListView.builder(
                                  itemCount: membersDocs.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: ListTile(
                                        leading: GestureDetector(
                                          onTap: () {
                                            viewModel
                                                .pushUserReviewToProfileView(
                                                    userEmail:
                                                        membersDocs[index]
                                                            ['memberEmail'],
                                                    userImage:
                                                        membersDocs[index]
                                                            ['userImage']);
                                          },
                                          child: Container(
                                              height: 36,
                                              width: 36,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(.5),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          membersDocs[index]
                                                              ['userImage'])))),
                                        ),
                                        title: Text(membersDocs[index]
                                            ['displayedName']),
                                        subtitle: Text(
                                          membersDocs[index]['role'],
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        dense: true,
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                  height: 70,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  )),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                        child: Row(
                          children: [
                            Tooltip(
                              message: 'Active challenges',
                              child: Text(
                                'Active challenges',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Spacer(),
                            Tooltip(
                              message: 'More Active challenges',
                              child: GestureDetector(
                                onTap: () {
                                  viewModel.pushComunityActiveChallengesView();
                                },
                                child: Icon(Icons.arrow_forward,
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder(
                        stream: viewModel.getCommunityActiveChallanges(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.isNotEmpty) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      viewModel.pushCommunityChallangesView(
                                          challengeName: snapshot.data.docs[index]
                                              ['challengeName'],
                                          bookTitle: snapshot.data.docs[index]
                                              ['bookTitle'],
                                          challengeRules: snapshot.data.docs[index]
                                              ['challengeRules'],
                                          challengeAuthors: snapshot.data.docs[index]
                                              ['bookId'],
                                          challangeId:
                                              snapshot.data.docs[index].id,
                                          bookId: snapshot.data.docs[index]
                                              ['bookId'],
                                          setToDate: snapshot.data.docs[index]
                                              ['setToDate'],
                                          challengeImage: snapshot.data.docs[index]
                                              ['challengeImage'],
                                          challengeDiscription:
                                              snapshot.data.docs[index]
                                                  ['challengeDiscription'],
                                          challangeType: 'Active',
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink']);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 3),
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
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    height: 210,
                                    child: Center(child: Text('isEmpty')),
                                  ),
                                ),
                              );
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                height: 210,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),

                SliverList(
                    delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    child: Row(
                      children: [
                        Tooltip(
                          message: 'Chat Rooms',
                          child: Text(
                            'Chat Rooms',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                    stream: viewModel.getCommunityRooms(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.isEmpty) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 230,
                                child: Center(
                                  child: Text('Comunity has no rooms yet 😭'),
                                ),
                              ));
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 230,
                            child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, int index) {
                                List<QueryDocumentSnapshot> roomsDoc =
                                    snapshot.data.docs;
                                roomsDoc.sort(
                                  (a, b) {
                                    int aInt = a
                                        .get('createdDate')
                                        .microsecondsSinceEpoch;
                                    int bInt = b
                                        .get('createdDate')
                                        .microsecondsSinceEpoch;
                                    return aInt.compareTo(bInt);
                                  },
                                );
                                if (index.isEven) {
                                  return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (await viewModel
                                              .cheackIfCurrentUserIsAMember()) {
                                            viewModel.pushRoom(
                                                roomId: roomsDoc[index].id,
                                                doorName: roomsDoc[index]
                                                    ['doorName']);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    content: Text(
                                                        'Please join the comunity first')));
                                          }
                                        },
                                        child: DoorType1Widget(
                                            doorName: roomsDoc[index]
                                                ['doorName']),
                                      ));
                                }
                                return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (await viewModel
                                            .cheackIfCurrentUserIsAMember()) {
                                          viewModel.pushRoom(
                                              roomId: roomsDoc[index].id,
                                              doorName: roomsDoc[index]
                                                  ['doorName']);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Text(
                                                      'Please join the comunity first')));
                                        }
                                      },
                                      child: DoorType2Widget(
                                          doorName: roomsDoc[index]
                                              ['doorName']),
                                    ));
                              },
                            ),
                          ),
                        );
                      }
                      return Container(
                        height: 230,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  )
                ])),

                SliverList(
                    delegate: SliverChildListDelegate([
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // OutlinedButtonWidget(
                  //   text: 'Send request',
                  //   message:
                  //       'Send a request to join message for the admin of the community',
                  //   onPressed: () {
                  //     viewModel.sendARequestToAGivenComunityToJoin();
                  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //         duration: Duration(seconds: 1),
                  //         content: Text('A request has been has sent')));
                  //   },
                  // ),
                  SizedBox(
                    height: 100,
                  )
                ]))
              ],
            ));
      },
      viewModelBuilder: () => ComunintyInformationViewModel(),
    );
  }
}
