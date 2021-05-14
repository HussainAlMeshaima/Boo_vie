import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'user_review_to_profile_view_model.dart';

class UserReviewToProfileView extends StatelessWidget {
  final String userEmail;
  final String userImage;

  const UserReviewToProfileView(
      {Key key, @required this.userEmail, @required this.userImage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserReviewToProfileViewModel>.reactive(
      onModelReady: (UserReviewToProfileViewModel viewModel) => viewModel
          .handleStartUpLogic(userEmail: userEmail, userImage: userImage),
      builder: (BuildContext context, UserReviewToProfileViewModel viewModel,
          Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('User Profile'),
            ),
            body: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 40,
                ),
                FutureBuilder(
                  future: viewModel.getOtherUserInformationDoc(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: Tooltip(
                          message: snapshot.data.get('userName') + ' image',
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userImage),
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  bottom: -40,
                                  child: Tooltip(
                                    message: snapshot.data.get('userName'),
                                    child: Text(snapshot.data.get('userName'),
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 55,
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 20, right: 20, bottom: 0),
                    child: FutureBuilder(
                      future: viewModel.getOtherUserInformationDoc(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            height: 80,
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0,
                                    right: 5,
                                    left: 5.0,
                                    bottom: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Tooltip(
                                      message: 'Total compleated challenges is ' +
                                          snapshot.data[
                                                  'userTotalCompleatedChallenges']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.timer,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data[
                                                    'userTotalCompleatedChallenges']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total trophies is ' +
                                          snapshot.data['userTotalTrophies']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.emoji_events,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data['userTotalTrophies']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total points is ' +
                                          snapshot.data['userTotalPoints']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.radio_button_checked,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data['userTotalPoints']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total Communities is ' +
                                          snapshot.data['userTotalCommunities']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.group_work,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot
                                                .data['userTotalCommunities']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total books reviwed is ' +
                                          snapshot.data['numberOfBookReviwed']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.sms,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data['numberOfBookReviwed']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total likes is ' +
                                          snapshot.data['userTotalLikes']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data['userTotalLikes']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: 80,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: viewModel.getOtherUserShelfsStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) return snapshot.error;

                      if (snapshot.hasData) {
                        if (snapshot.data.size == 0) {
                          return Container(
                            height: 200,
                            child: Center(
                                child: Text(
                                    'Seems Like you dont have any shelf yet 😭')),
                          );
                        }
                        if (snapshot.data.size != 0) {
                          List<QueryDocumentSnapshot> shelfsDocs =
                              snapshot.data.docs;

                          shelfsDocs.sort((a, b) {
                            int aInt =
                                a.get('createdDate').microsecondsSinceEpoch;
                            int bInt =
                                b.get('createdDate').microsecondsSinceEpoch;
                            return bInt.compareTo(aInt);
                          });
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: shelfsDocs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListView(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20.0, top: 12),
                                      child: Container(
                                        child: Tooltip(
                                          message: shelfsDocs[index]['name'],
                                          child: Text(
                                            shelfsDocs[index]['name'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    StreamBuilder(
                                        stream: viewModel
                                            .getOtherUserBooksInThatShelfStream(
                                          shelfName: shelfsDocs[index].id,
                                        ),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            List<QueryDocumentSnapshot>
                                                booksDocs = snapshot.data.docs;

                                            return ListView(
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        snapshot.data.size,
                                                    itemBuilder:
                                                        (context, index) {
                                                      booksDocs.sort((a, b) {
                                                        int aInt = a
                                                            .get('openedDate')
                                                            .microsecondsSinceEpoch;
                                                        int bInt = b
                                                            .get('openedDate')
                                                            .microsecondsSinceEpoch;
                                                        return bInt
                                                            .compareTo(aInt);
                                                      });
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            viewModel.pushBookView(
                                                                authors: booksDocs[
                                                                        index]
                                                                    ['authors'],
                                                                id: booksDocs[
                                                                        index]
                                                                    ['id'],
                                                                image: booksDocs[
                                                                        index]
                                                                    [
                                                                    'thumbnail'],
                                                                bookTitle: booksDocs[
                                                                        index]
                                                                    ['title'],
                                                                previewLink:
                                                                    booksDocs[
                                                                            index]
                                                                        ['previewLink']);
                                                          },
                                                          child: Tooltip(
                                                            message:
                                                                booksDocs[index]
                                                                    ['title'],
                                                            child: Container(
                                                              height: 150,
                                                              width: 110,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        .5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(
                                                                      booksDocs[
                                                                              index]
                                                                          [
                                                                          'thumbnail']),
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 8),
                                                  child: Container(
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(.5),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                              ],
                                            );
                                          }

                                          return Container(
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }),
                                  ],
                                );
                              });
                        }
                      }
                      if (!snapshot.hasData) {
                        return Container(
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Container(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    })
              ],
            ));
      },
      viewModelBuilder: () => UserReviewToProfileViewModel(),
    );
  }
}
