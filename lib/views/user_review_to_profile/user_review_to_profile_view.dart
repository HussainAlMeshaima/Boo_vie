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
              physics: ScrollPhysics(),
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Hero(
                    tag: viewModel.userEmail,
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xffE7E7E7)
                                  : Color(0xff656565).withOpacity(0.4),
                          borderRadius: BorderRadiusDirectional.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(viewModel.userImage),
                          )),
                    ),
                  ),
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
                              physics: ScrollPhysics(),
                              itemCount: shelfsDocs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20.0, top: 12),
                                      child: Container(
                                        child: Text(
                                          shelfsDocs[index]['name'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
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
                                              physics: ScrollPhysics(),
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
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
                                                          child: Hero(
                                                            tag:
                                                                booksDocs[index]
                                                                    ['id'],
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
