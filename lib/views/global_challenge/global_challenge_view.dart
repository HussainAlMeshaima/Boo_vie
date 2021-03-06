import 'dart:async';
import 'dart:ui';

import 'package:boo_vi_app/widgets/smart_widgets/create_a_new_shelf_with_name/create_a_new_shelf_with_name_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';
import 'global_challenge_view_model.dart';

class GlobalChallengeView extends StatelessWidget {
  final String challangeId;
  final String challengeName;
  final Timestamp setToDate;

  final String image;

  final String bookId;
  final String bookTitle;
  final String challengeAuthors;
  final String previewLink;

  final int challengeLikeCounter;
  final int numberOfPeopleWhoHasTheChallengeCount;
  final int numberOfCommentsCount;
  final String challengeDiscription;
  final int trophiesCount;
  final List challengeRules;
  final int numberOfCommunitiesWhoHasThatChallangeCount;
  final Map trophiesMap;

  const GlobalChallengeView({
    Key key,
    @required this.image,
    @required this.challangeId,
    @required this.bookId,
    @required this.challengeAuthors,
    @required this.challengeName,
    @required this.previewLink,
    @required this.bookTitle,
    @required this.challengeLikeCounter,
    @required this.numberOfPeopleWhoHasTheChallengeCount,
    @required this.setToDate,
    @required this.numberOfCommentsCount,
    @required this.challengeDiscription,
    @required this.trophiesCount,
    @required this.challengeRules,
    @required this.numberOfCommunitiesWhoHasThatChallangeCount,
    @required this.trophiesMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GlobalChallengeViewModel>.reactive(
      onModelReady: (GlobalChallengeViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        challangeId: challangeId,
        bookId: bookId,
        challengeImage: image,
        challengeAuthors: challengeAuthors,
        challengeName: challengeName,
        previewLink: previewLink,
        bookTitle: bookTitle,
        setToDate: setToDate,
        numberOfCommentsCount: numberOfCommentsCount,
        challengeDiscription: challengeDiscription,
        challengeLikeCounter: challengeLikeCounter,
        trophiesCount: trophiesCount,
        trophiesMap: trophiesMap,
        challengeRules: challengeRules,
        numberOfCommunitiesWhoHasThatChallangeCount:
            numberOfCommunitiesWhoHasThatChallangeCount,
      ),
      builder:
          (BuildContext context, GlobalChallengeViewModel viewModel, Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Global Challenge'),
              actions: [
                Tooltip(
                  message: 'Share',
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                    ),
                    onPressed: () {
                      Share.share(
                        viewModel.previewLink,
                        subject: viewModel.challengeName,
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add button',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          Tooltip(
                            message: 'Add What ?',
                            child: ListTile(
                              title: Text(
                                'Add What ?',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // ! Add a comment
                          Tooltip(
                            message: 'Add a comment to challange',
                            child: GestureDetector(
                              onTap: () async {
                                await showModalBottomSheet(
                                  context: context,
                                  builder: (
                                    context,
                                  ) {
                                    return GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                      },
                                      child: Container(
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            Tooltip(
                                              message:
                                                  'Add a comment to challange',
                                              child: ListTile(
                                                title: Text(
                                                  'Add a comment to challange',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextfieldWidget(
                                              maxLines: 5,
                                              controller:
                                                  viewModel.commentController,
                                              onSubmitted: (commentText) async {
                                                Navigator.pop(
                                                  context,
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                    content: Text(
                                                      'Comments updated',
                                                    ),
                                                  ),
                                                );
                                                await viewModel
                                                    .addACommentToAGlobalChallange();
                                                viewModel.commentController
                                                    .clear();
                                              },
                                            ),
                                            ElevatedButtonWidget(
                                              text: 'Send',
                                              onPressed: () async {
                                                Navigator.pop(
                                                  context,
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                    content: Text(
                                                      'Comments updated',
                                                    ),
                                                  ),
                                                );
                                                await viewModel
                                                    .addACommentToAGlobalChallange();
                                                viewModel.commentController
                                                    .clear();
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 5,
                                ),
                                child: Tooltip(
                                  message: 'Add a comment to challange',
                                  child: ListTile(
                                    leading: Icon(Icons.textsms,
                                        color: Theme.of(context).primaryColor),
                                    title: Text('Add a comment to challange'),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                context,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(
                                    seconds: 1,
                                  ),
                                  content: Text('Like updated'),
                                ),
                              );
                              viewModel.addALikeToChallange();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 5,
                              ),
                              child: Tooltip(
                                message: 'Add a like to challange',
                                child: ListTile(
                                  leading: Icon(
                                    Icons.favorite,
                                    color: Theme.of(
                                      context,
                                    ).primaryColor,
                                  ),
                                  title: Text('Add a like to challange'),
                                ),
                              ),
                            ),
                          ),

                          // ! Add book to a shelf
                          Tooltip(
                            message: 'Add book to a shelf',
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: GestureDetector(
                                        onTap: () =>
                                            FocusScope.of(context).unfocus(),
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            Tooltip(
                                              message: 'Choose your shelf',
                                              child: ListTile(
                                                title: Text(
                                                  'Choose your shelf',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(
                                                  context,
                                                );
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(
                                                          context,
                                                        ).unfocus();
                                                      },
                                                      child:
                                                          CreateANewShelfWithNameWidget(
                                                        authours: viewModel
                                                            .bookAuthors,
                                                        bookId:
                                                            viewModel.bookId,
                                                        bookImage:
                                                            viewModel.image,
                                                        bookTitle:
                                                            viewModel.bookTitle,
                                                        bookpreviewLink:
                                                            viewModel
                                                                .previewLink,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12.0,
                                                  vertical: 5,
                                                ),
                                                child: Tooltip(
                                                  message: 'Create a new shelf',
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.clear_all,
                                                      color: Theme.of(
                                                        context,
                                                      ).primaryColor,
                                                    ),
                                                    title: Text(
                                                      'Create a new shelf',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                bottom: 8,
                                              ),
                                              child: Container(
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(
                                                        .5,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            StreamBuilder(
                                              stream: viewModel
                                                  .getUserShelfsStream(),
                                              builder: (
                                                BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot,
                                              ) {
                                                if (snapshot.hasError)
                                                  return snapshot.error;

                                                if (snapshot.hasData) {
                                                  if (snapshot.data.size == 0) {
                                                    return Tooltip(
                                                      message:
                                                          'Seems Like you dont have any shelf yet',
                                                      child: Container(
                                                        height: 200,
                                                        child: Center(
                                                          child: Text(
                                                            'Seems Like you dont have any shelf yet????',
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  if (snapshot.data.size != 0) {
                                                    List<QueryDocumentSnapshot>
                                                        shelfsDocs =
                                                        snapshot.data.docs;

                                                    shelfsDocs.sort(
                                                      (a, b) {
                                                        int aInt = a
                                                            .get(
                                                              'createdDate',
                                                            )
                                                            .microsecondsSinceEpoch;
                                                        int bInt = b
                                                            .get(
                                                              'createdDate',
                                                            )
                                                            .microsecondsSinceEpoch;
                                                        return bInt.compareTo(
                                                          aInt,
                                                        );
                                                      },
                                                    );
                                                    return ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemCount:
                                                          shelfsDocs.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            2),
                                                                content: Text(
                                                                  'Book added to ' +
                                                                      shelfsDocs[
                                                                              index]
                                                                          .id,
                                                                ),
                                                              ),
                                                            );
                                                            Timer(
                                                              Duration(
                                                                seconds: 2,
                                                              ),
                                                              () {
                                                                viewModel.addAbooktoSelectedShelf(
                                                                    shelfId:
                                                                        shelfsDocs[index]
                                                                            .id,
                                                                    bookId: viewModel
                                                                        .bookId,
                                                                    bookImage:
                                                                        viewModel
                                                                            .image,
                                                                    previewLink:
                                                                        viewModel
                                                                            .previewLink,
                                                                    title: viewModel
                                                                        .bookTitle);
                                                              },
                                                            );
                                                          },
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            physics:
                                                                BouncingScrollPhysics(),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  right: 20,
                                                                  left: 20.0,
                                                                  top: 12,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      Tooltip(
                                                                    message: 'Shelf name is ' +
                                                                        shelfsDocs[index]
                                                                            [
                                                                            'name'],
                                                                    child: Text(
                                                                      shelfsDocs[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              StreamBuilder(
                                                                stream: viewModel
                                                                    .getUserBooksInThatShelfStream(
                                                                  shelfName:
                                                                      shelfsDocs[
                                                                              index]
                                                                          .id,
                                                                ),
                                                                builder: (
                                                                  BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          QuerySnapshot>
                                                                      snapshot,
                                                                ) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    List<QueryDocumentSnapshot>
                                                                        booksDocs =
                                                                        snapshot
                                                                            .data
                                                                            .docs;

                                                                    return ListView(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      children: [
                                                                        Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          height:
                                                                              200,
                                                                          child:
                                                                              ListView.builder(
                                                                            shrinkWrap:
                                                                                true,
                                                                            physics:
                                                                                BouncingScrollPhysics(),
                                                                            scrollDirection:
                                                                                Axis.horizontal,
                                                                            itemCount:
                                                                                snapshot.data.size,
                                                                            itemBuilder:
                                                                                (context, index) {
                                                                              booksDocs.sort(
                                                                                (a, b) {
                                                                                  int aInt = a
                                                                                      .get(
                                                                                        'openedDate',
                                                                                      )
                                                                                      .microsecondsSinceEpoch;
                                                                                  int bInt = b
                                                                                      .get(
                                                                                        'openedDate',
                                                                                      )
                                                                                      .microsecondsSinceEpoch;
                                                                                  return bInt.compareTo(
                                                                                    aInt,
                                                                                  );
                                                                                },
                                                                              );
                                                                              return Padding(
                                                                                padding: const EdgeInsets.all(12.0),
                                                                                child: GestureDetector(
                                                                                  child: Hero(
                                                                                    tag: booksDocs[index]['id'],
                                                                                    child: Tooltip(
                                                                                      message: booksDocs[index]['title'],
                                                                                      child: Container(
                                                                                        height: 150,
                                                                                        width: 110,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Theme.of(context).primaryColor.withOpacity(
                                                                                                .5,
                                                                                              ),
                                                                                          borderRadius: BorderRadius.circular(
                                                                                            8,
                                                                                          ),
                                                                                          image: DecorationImage(
                                                                                            fit: BoxFit.cover,
                                                                                            image: NetworkImage(
                                                                                              booksDocs[index]['thumbnail'],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 8),
                                                                          child:
                                                                              Tooltip(
                                                                            message:
                                                                                'A Shelf',
                                                                            child:
                                                                                Container(
                                                                              height: 12,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                color: Theme.of(context).primaryColor.withOpacity(.5),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              30,
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }

                                                                  return Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                }
                                                if (!snapshot.hasData) {
                                                  return Container(
                                                    height: 300,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  );
                                                }
                                                return Container(
                                                  height: 300,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 5,
                                ),
                                child: Tooltip(
                                  message: 'Add book to a shelf',
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.clear_all,
                                      color: Theme.of(
                                        context,
                                      ).primaryColor,
                                    ),
                                    title: Text('Add book to a shelf'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // ! Add as a challenge
                          Tooltip(
                            message: 'Add book as a challenge',
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                  context,
                                );
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () =>
                                          FocusScope.of(context).unfocus(),
                                      child: Container(
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            Tooltip(
                                              message: 'Challenge type',
                                              child: ListTile(
                                                title: Text(
                                                  'Challenge type',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(
                                                  context,
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(SnackBar(
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                    content: Text(
                                                        'My Challange has been updated')));
                                                viewModel
                                                    .addTheSelectedChallangeToMyChallanges();
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12.0,
                                                  vertical: 5,
                                                ),
                                                child: Tooltip(
                                                  message:
                                                      'Add to my challenges',
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.person,
                                                      color: Theme.of(
                                                        context,
                                                      ).primaryColor,
                                                    ),
                                                    title: Text(
                                                        'Add to my challenges'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 5,
                                              ),
                                              child: Tooltip(
                                                message:
                                                    'Add as a community challenge',
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.group_work,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  title: Text(
                                                      'Add as a community challenge'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 5),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.timer,
                                    color: Theme.of(
                                      context,
                                    ).primaryColor,
                                  ),
                                  title: Text('Add book as a challenge'),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.pushBookView(),
                        onDoubleTap: () {
                          viewModel.addALikeToChallange();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Like updated'),
                            ),
                          );
                        },
                        child: Tooltip(
                          message: 'Book image',
                          child: Center(
                            child: Hero(
                              tag: bookId,
                              child: Container(
                                height: 320,
                                width: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(image),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      StreamBuilder(
                        stream: viewModel.getGlobalChallangeSetToDateStream(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot,
                        ) {
                          if (snapshot.hasData) {
                            Timestamp setToDate =
                                snapshot.data.data()['setToDate'];
                            String _days =
                                viewModel.convertTheGivenTimestampToDays(
                              setToDate,
                            );
                            String _hours =
                                viewModel.convertTheGivenTimestampToHours(
                              setToDate,
                            );
                            String _minutes =
                                viewModel.convertTheGivenTimestampToMinutes(
                              setToDate,
                            );
                            String _seconds =
                                viewModel.convertTheGivenTimestampToSeconds(
                              setToDate,
                            );

                            return Tooltip(
                              message: 'The remaining for this challenge is ' +
                                  _days +
                                  ' days ' +
                                  _hours +
                                  ' hours ' +
                                  _minutes +
                                  ' minutes and ' +
                                  _seconds +
                                  ' seconds',
                              child: Container(
                                height: 120,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    15.0,
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        20.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            colorFilter: new ColorFilter.mode(
                                              Colors.black.withOpacity(
                                                0.5,
                                              ),
                                              BlendMode.dstATop,
                                            ),
                                            image: NetworkImage(
                                              image,
                                            ),
                                          ),
                                        ),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 10,
                                            sigmaY: 10,
                                            tileMode: TileMode.clamp,
                                          ),
                                          child: Container(
                                            color: Theme.of(
                                                      context,
                                                    ).brightness ==
                                                    Brightness.dark
                                                ? Colors.black.withOpacity(
                                                    0.5,
                                                  )
                                                : Colors.white.withOpacity(
                                                    0.5,
                                                  ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 24,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        _days,
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                        ),
                                                      ),
                                                      Text(
                                                        'DAYS',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .color
                                                                  .withOpacity(
                                                                    .35,
                                                                  ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    ':',
                                                    style: TextStyle(
                                                      fontSize: 26,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .color
                                                          .withOpacity(
                                                            .7,
                                                          ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        _hours,
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                        ),
                                                      ),
                                                      Text(
                                                        'HOUR',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .color
                                                                  .withOpacity(
                                                                    .35,
                                                                  ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    ':',
                                                    style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .color
                                                            .withOpacity(
                                                              .7,
                                                            )),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        _minutes,
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                        ),
                                                      ),
                                                      Text(
                                                        'MIN',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .color
                                                                  .withOpacity(
                                                                    .35,
                                                                  ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    ':',
                                                    style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .color
                                                            .withOpacity(
                                                              .7,
                                                            )),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        _seconds,
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                        ),
                                                      ),
                                                      Text(
                                                        'SEC',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .color
                                                                  .withOpacity(
                                                                    .35,
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
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container(
                            height: 120,
                            child: Container(
                              height: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  15.0,
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      15,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15,
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          colorFilter: new ColorFilter.mode(
                                            Colors.black.withOpacity(
                                              0.5,
                                            ),
                                            BlendMode.dstATop,
                                          ),
                                          image: NetworkImage(
                                            image,
                                          ),
                                        ),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10,
                                          sigmaY: 10,
                                          tileMode: TileMode.clamp,
                                        ),
                                        child: Container(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.black.withOpacity(
                                                  0.5,
                                                )
                                              : Colors.white.withOpacity(
                                                  0.5,
                                                ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                            ),
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Tooltip(
                              message: 'About Challenge',
                              child: Text(
                                'About Challenge',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder(
                        stream: viewModel.getGlobalChallengeStream(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot,
                        ) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 110,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 28,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Tooltip(
                                          message:
                                              'Number of trophies that you will gain is ' +
                                                  snapshot.data['trophiesCount']
                                                      .toString(),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.emoji_events,
                                              ),
                                              Text(
                                                snapshot.data['trophiesCount']
                                                    .toString(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Tooltip(
                                          message:
                                              'Number of communities who has that challange is ' +
                                                  snapshot.data[
                                                          'numberOfCommunitiesWhoHasThatChallangeCount']
                                                      .toString(),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.group_work,
                                              ),
                                              Text(
                                                snapshot.data[
                                                        'numberOfCommunitiesWhoHasThatChallangeCount']
                                                    .toString(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Tooltip(
                                          message:
                                              'Number of people who has that challenge is ' +
                                                  snapshot.data[
                                                          'numberOfPeopleWhoHasThatChallengeCount']
                                                      .toString(),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.people,
                                              ),
                                              Text(
                                                snapshot.data[
                                                        'numberOfPeopleWhoHasThatChallengeCount']
                                                    .toString(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Tooltip(
                                          message:
                                              'Number of people who has liked that challenge is ' +
                                                  snapshot.data[
                                                          'challengeLikeCounter']
                                                      .toString(),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              StreamBuilder(
                                                stream: viewModel
                                                    .getGlobalChallengeIsLikedByUserStream(),
                                                builder: (
                                                  BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshot,
                                                ) {
                                                  if (snapshot.hasData) {
                                                    bool isChallangeLiked =
                                                        false;
                                                    if (!snapshot.data.exists) {
                                                      isChallangeLiked = false;
                                                    } else if (snapshot
                                                        .data.exists) {
                                                      print(
                                                        snapshot.data.data()[
                                                            'isChallangeLiked'],
                                                      );
                                                      isChallangeLiked = snapshot
                                                              .data
                                                              .data()[
                                                          'isChallangeLiked'];
                                                    }

                                                    if (isChallangeLiked) {
                                                      return Icon(
                                                        Icons.favorite,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      );
                                                    } else {
                                                      return Icon(Icons
                                                          .favorite_border);
                                                    }
                                                  }
                                                  return Container(
                                                    height: 24,
                                                    width: 24,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Text(
                                                snapshot.data[
                                                        'challengeLikeCounter']
                                                    .toString(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.sms),
                                            Text(
                                              snapshot
                                                  .data['numberOfCommentsCount']
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container(
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Tooltip(
                              message: 'Challenge Rules',
                              child: Text(
                                'Rules',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              child: StreamBuilder(
                                stream: viewModel.getChallangeDocument(
                                  challangeId,
                                ),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot,
                                ) {
                                  if (snapshot.hasError) return snapshot.error;

                                  if (snapshot.hasData) {
                                    if (snapshot.data['challengeRules'] ==
                                            null ||
                                        snapshot.data['challengeRules']
                                                .length ==
                                            0) {
                                      return Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                            20.0,
                                          ),
                                          child: Text(
                                              'Rules are not set for this challange ????'),
                                        ),
                                      );
                                    } else if (snapshot.data['challengeRules']
                                                .length !=
                                            0 &&
                                        snapshot.data['challengeRules'] !=
                                            null) {
                                      List<dynamic> challengeRules =
                                          snapshot.data['challengeRules'];
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: challengeRules.length,
                                        itemBuilder: (
                                          context,
                                          index,
                                        ) {
                                          return Tooltip(
                                            message: challengeRules[index],
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  12.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        challengeRules[index],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }

                                  return Container(
                                    height: 150,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Tooltip(
                              message: 'Challenge Description',
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          child: Container(
                            child: StreamBuilder(
                              stream: viewModel.getChallangeDocument(
                                challangeId,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) return snapshot.error;

                                if (snapshot.hasData) {
                                  if (snapshot.data['challengeDiscription'] ==
                                      null) {
                                    return Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          'Discription is not set for this challange ????',
                                        ),
                                      ),
                                    );
                                  }
                                  String challengeDiscription = snapshot
                                      .data['challengeDiscription']
                                      .replaceAll(
                                    RegExp(r"<[^>]*>",
                                        multiLine: true, caseSensitive: true),
                                    '',
                                  );

                                  if (challengeDiscription != null) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        challengeDiscription,
                                      ),
                                    );
                                  }
                                }

                                return Container(
                                  height: 150,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Tooltip(
                              message: 'Challenge Comments',
                              child: Text(
                                'Comments',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(
                              0.0,
                            ),
                            child: StreamBuilder(
                              stream: viewModel.getChallangeComments(
                                challangeId,
                              ),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot,
                              ) {
                                if (snapshot.hasError) return snapshot.error;

                                if (snapshot.hasData) {
                                  if (snapshot.data.docs.length == 0 ||
                                      snapshot.data.docs == null) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(),
                                        ),
                                        title: Text(
                                          'No Commnets yet ????',
                                        ),
                                      ),
                                    );
                                  } else {
                                    List<QueryDocumentSnapshot> docs =
                                        snapshot.data.docs;

                                    docs.sort(
                                      (a, b) {
                                        int aInt = a
                                            .get('sendDate')
                                            .microsecondsSinceEpoch;
                                        int bInt = b
                                            .get('sendDate')
                                            .microsecondsSinceEpoch;
                                        return aInt.compareTo(
                                          bInt,
                                        );
                                      },
                                    );

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: docs.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ListTile(
                                              leading: GestureDetector(
                                                onTap: () {
                                                  viewModel.pushUserReviewToProfileCommentView(
                                                      userImageComment: docs[
                                                              index]
                                                          ['userImageComment'],
                                                      userEmailComment: docs[
                                                              index]
                                                          ['userEmailComment']);
                                                },
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(docs[
                                                                  index][
                                                              'userImageComment']))),
                                                ),
                                              ),
                                              title: Text(docs[index]
                                                  ['userNameComment']),
                                              subtitle: Text(
                                                  docs[index]['userComment']),
                                              trailing: Text(
                                                DateFormat.jm().format(
                                                    docs[index]['sendDate']
                                                        .toDate()),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }

                                return Container(
                                  height: 150,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
      viewModelBuilder: () => GlobalChallengeViewModel(),
    );
  }
}
