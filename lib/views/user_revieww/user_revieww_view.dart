import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'user_revieww_view_model.dart';
import 'package:intl/intl.dart';

class UserReviewwView extends StatelessWidget {
  final String tappedUserEmail;
  final String bookId;

  const UserReviewwView(
      {Key key, @required this.tappedUserEmail, @required this.bookId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserReviewwViewModel>.reactive(
      onModelReady: (UserReviewwViewModel viewModel) => viewModel
          .handleStartUpLogic(bookId: bookId, tappedUserEmail: tappedUserEmail),
      builder:
          (BuildContext context, UserReviewwViewModel viewModel, Widget _) {
        return Scaffold(
            appBar: AppBar(title: Text('Review')),
            body: StreamBuilder(
              stream: viewModel.getUserReviewsStream(
                  bookId: bookId, tappedUserEmail: tappedUserEmail),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) return snapshot.error;
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data = snapshot.data.data();

                    int userReviewEmojiRating =
                        data['userReviewEmojiRating'].toInt();

                    String emoji;

                    switch (userReviewEmojiRating) {
                      case 0:
                        emoji = '🤢';
                        break;

                      case 1:
                        emoji = '🤮';
                        break;

                      case 2:
                        emoji = '😫';
                        break;

                      case 3:
                        emoji = '😧';
                        break;

                      case 4:
                        emoji = '😟';
                        break;

                      case 5:
                        emoji = '😕';
                        break;

                      case 6:
                        emoji = '🤨';
                        break;

                      case 7:
                        emoji = '😃';
                        break;

                      case 8:
                        emoji = '😇';
                        break;

                      case 9:
                        emoji = '😍';
                        break;

                      case 10:
                        emoji = '🥰';
                        break;

                      default:
                        emoji = '🥱';

                        break;
                    }

                    return ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(data[
                                                              'userImage'])))),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data['userName'].length >
                                                              14
                                                          ? data['userName']
                                                                  .substring(
                                                                      0, 14) +
                                                              '..'
                                                          : data['userName'],
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      DateFormat.yMd().format(
                                                          data['reviewDateTime']
                                                              .toDate()),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  emoji.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 230,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 4),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .chat_bubble_outline,
                                                                size: 15,
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                data['reviewCommentsConter']
                                                                    .toInt()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                            height: 20,
                                                            width: 2,
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .iconTheme
                                                                    .color,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                size: 15,
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                data['reviewLikeConter']
                                                                    .toInt()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                            height: 20,
                                                            width: 2,
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .iconTheme
                                                                    .color,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Icon(
                                                                Icons.schedule,
                                                                size: 15,
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                DateFormat(
                                                                        'H:m a')
                                                                    .format(data[
                                                                            'reviewDateTime']
                                                                        .toDate()),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child:
                                                Text(data['userReviewString']),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton.icon(
                                                icon: Icon(
                                                  Icons.chat_bubble_outline,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  size: 17,
                                                ),
                                                label: Text('Comment'),
                                                style: ElevatedButton.styleFrom(
                                                  onPrimary: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .color
                                                      : Colors.black,
                                                  primary: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              2.5,
                                                          child: ListView(
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                  'Add a comment',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              TextfieldWidget(
                                                                maxLines: 5,
                                                                onSubmitted:
                                                                    (commentText) {
                                                                  viewModel.addACommentToABook(
                                                                      commentString:
                                                                          commentText,
                                                                      tappedUserEmail:
                                                                          tappedUserEmail);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton.icon(
                                                icon: FutureBuilder(
                                                  future: viewModel
                                                      .getLikeBoolValue(bookId),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              DocumentSnapshot>
                                                          snapshot) {
                                                    if (snapshot.hasData) {
                                                      bool isTrue =
                                                          snapshot.data.data()[
                                                              'isReviewLiked'];
                                                      print(isTrue);
                                                      if (isTrue) {
                                                        return Icon(
                                                          Icons.favorite,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          size: 17,
                                                        );
                                                      }
                                                      return Icon(
                                                        Icons.favorite_border,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 17,
                                                      );
                                                    }
                                                    return Container(
                                                      height: 17,
                                                      width: 17,
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                label: Text('Like'),
                                                style: ElevatedButton.styleFrom(
                                                  onPrimary: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .color
                                                      : Colors.black,
                                                  primary: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  viewModel.addAlikeToABook(
                                                      tappedUserEmail:
                                                          tappedUserEmail);
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: StreamBuilder(
                            stream: viewModel.getReviewComments(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children:
                                        snapshot.data.docs.map<Widget>((doc) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              leading: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    image: DecorationImage(
                                                        image: NetworkImage(doc[
                                                            'userImageComment']))),
                                              ),
                                              title: Text(doc['userComment']),
                                              subtitle:
                                                  Text(doc['userComment']),
                                              trailing: Text(
                                                DateFormat.jm().format(
                                                    doc['sendDate'].toDate()),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList());
                              }
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
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
            ));
      },
      viewModelBuilder: () => UserReviewwViewModel(),
    );
  }
}
