import 'dart:ui';

import 'package:boo_vi_app/widgets/smart_widgets/edit_review_sheet/edit_review_sheet_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'user_revieww_view_model.dart';
import 'package:intl/intl.dart';

class UserReviewwView extends StatelessWidget {
  final String tappedUserEmail;
  final String bookId;
  final String bookImage;

  final bool spoiler;
  final bool bookPageSpoiler;
  final String userReviewString;
  final double userReviewEmojiRating;
  final double userReviewEmojiRatingDouble;

  const UserReviewwView({
    Key key,
    @required this.tappedUserEmail,
    @required this.bookId,
    @required this.bookImage,
    @required this.spoiler,
    @required this.bookPageSpoiler,
    @required this.userReviewString,
    @required this.userReviewEmojiRating,
    this.userReviewEmojiRatingDouble,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserReviewwViewModel>.reactive(
      onModelReady: (UserReviewwViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        bookId: bookId,
        tappedUserEmail: tappedUserEmail,
        bookImage: bookImage,
        spoiler: spoiler,
        userReviewString: userReviewString,
        bookPageSpoiler: bookPageSpoiler,
        userReviewEmojiRating: userReviewEmojiRating,
      ),
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
                        emoji = '????';
                        break;

                      case 1:
                        emoji = '????';
                        break;

                      case 2:
                        emoji = '????';
                        break;

                      case 3:
                        emoji = '????';
                        break;

                      case 4:
                        emoji = '????';
                        break;

                      case 5:
                        emoji = '????';
                        break;

                      case 6:
                        emoji = '????';
                        break;

                      case 7:
                        emoji = '????';
                        break;

                      case 8:
                        emoji = '????';
                        break;

                      case 9:
                        emoji = '????';
                        break;

                      case 10:
                        emoji = '????';
                        break;

                      case 11:
                        emoji = '????';
                        break;

                      case 12:
                        emoji = '????';
                        break;

                      case 13:
                        emoji = '????';
                        break;

                      case 14:
                        emoji = '????';
                        break;

                      default:
                        emoji = '????';

                        break;
                    }

                    return ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          child: ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13),
                                child: Container(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            colorFilter: new ColorFilter.mode(
                                                Colors.black.withOpacity(0.5),
                                                BlendMode.dstATop),
                                            image: NetworkImage(
                                              snapshot.data.data()['bookImage'],
                                            ),
                                          ),
                                        ),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10,
                                              sigmaY: 10,
                                              tileMode: TileMode.clamp),
                                          child: Container(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? Colors.black.withOpacity(0.5)
                                                : Colors.white.withOpacity(0.5),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Tooltip(
                                                              message: data[
                                                                      'userName'] +
                                                                  ' profile image',
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  viewModel
                                                                      .pushUserReviewToProfileView();
                                                                },
                                                                child: Container(
                                                                    height: 65,
                                                                    width: 65,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                12),
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image: NetworkImage(data['userImage'])))),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Tooltip(
                                                                message: data[
                                                                    'userName'],
                                                                child:
                                                                    Container(
                                                                  width: 134,
                                                                  child: Text(
                                                                    data['userName'].length >
                                                                            20
                                                                        ? data['userName'].substring(0,
                                                                                20) +
                                                                            '..'
                                                                        : data[
                                                                            'userName'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Tooltip(
                                                                message: data[
                                                                        'userName'] +
                                                                    ' have sent a review on ' +
                                                                    DateFormat
                                                                            .yMd()
                                                                        .format(
                                                                      data['reviewDateTime']
                                                                          .toDate(),
                                                                    ),
                                                                child: Text(
                                                                  DateFormat
                                                                          .yMd()
                                                                      .format(data[
                                                                              'reviewDateTime']
                                                                          .toDate()),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        13,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        FutureBuilder(
                                                          future: viewModel
                                                              .getUserEmail(),
                                                          builder: (context,
                                                              AsyncSnapshot
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              if (snapshot
                                                                      .data ==
                                                                  data[
                                                                      'userEmail']) {
                                                                return Tooltip(
                                                                  message:
                                                                      'Edit my message',
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      showModalBottomSheet(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return ListView(
                                                                              shrinkWrap: true,
                                                                              physics: BouncingScrollPhysics(),
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(0.0),
                                                                                  child: Container(
                                                                                    child: Padding(
                                                                                        padding: const EdgeInsets.all(0.0),
                                                                                        child: ListTile(
                                                                                          title: Text(
                                                                                            'Edit review',
                                                                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                        )),
                                                                                  ),
                                                                                ),
                                                                                EditReviewSheetWidget(
                                                                                  bookId: bookId,
                                                                                  spoiler: spoiler,
                                                                                  bookPageSpoiler: viewModel.bookPageSpoiler,
                                                                                  userReviewString: userReviewString,
                                                                                  userReviewEmojiRating: userReviewEmojiRatingDouble,
                                                                                ),
                                                                              ],
                                                                            );
                                                                          });
                                                                    },
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.all(20.0),
                                                                        child: Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              Theme.of(context).primaryColor,
                                                                        )),
                                                                  ),
                                                                );
                                                              } else {
                                                                return GestureDetector(
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.only(top: 10, right: 10),
                                                                      child: Container(
                                                                        height:
                                                                            70,
                                                                        width:
                                                                            55,
                                                                        child:
                                                                            ListView(
                                                                          shrinkWrap:
                                                                              true,
                                                                          physics:
                                                                              BouncingScrollPhysics(),
                                                                          children: [
                                                                            Text(
                                                                              '????',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontSize: 15),
                                                                            ),
                                                                            Switch(
                                                                                activeColor: Theme.of(context).primaryColor,
                                                                                value: viewModel.spoiler,
                                                                                onChanged: (value) {
                                                                                  viewModel.toggleSpoiler(value);
                                                                                })
                                                                          ],
                                                                        ),
                                                                      )),
                                                                );
                                                              }
                                                            }
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                child: Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 0,
                                                                vertical: 6),
                                                        child: Container(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 5),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Tooltip(
                                                                message: data[
                                                                        'userName'] +
                                                                    ' has rated book with ' +
                                                                    emoji,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      emoji
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          color: Theme.of(context)
                                                                              .primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 20,
                                                                width: 1,
                                                                decoration: BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .iconTheme
                                                                        .color,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                              ),
                                                              Tooltip(
                                                                message: 'Total comments are ' +
                                                                    data['reviewCommentsConter']
                                                                        .toInt()
                                                                        .toString(),
                                                                child: Column(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .chat_bubble_outline,
                                                                      size: 18,
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
                                                                              15,
                                                                          color: Theme.of(context)
                                                                              .primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 20,
                                                                width: 1,
                                                                decoration: BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .iconTheme
                                                                        .color,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                              ),
                                                              Tooltip(
                                                                message: 'Total Likes are ' +
                                                                    data['reviewLikeConter']
                                                                        .toInt()
                                                                        .toString(),
                                                                child: Column(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .favorite_border,
                                                                      size: 18,
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
                                                                              15,
                                                                          color: Theme.of(context)
                                                                              .primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 20,
                                                                width: 1,
                                                                decoration: BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .iconTheme
                                                                        .color,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                              ),
                                                              Tooltip(
                                                                message: 'Review has been sent at ' +
                                                                    DateFormat(
                                                                            'h:mm:ss a')
                                                                        .format(
                                                                            data['reviewDateTime'].toDate()),
                                                                child: Column(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .schedule,
                                                                      size: 18,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              'h:mm a')
                                                                          .format(
                                                                              data['reviewDateTime'].toDate()),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Theme.of(context)
                                                                              .primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                      ),
                                                    ),
                                                    Tooltip(
                                                      message: !viewModel
                                                              .spoiler
                                                          ? data[
                                                              'userReviewString']
                                                          : 'The review Containes spoilers ????',
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 4),
                                                        child: Text(
                                                          !viewModel.spoiler
                                                              ? data[
                                                                  'userReviewString']
                                                              : '????????????????????????????????????????????????????????????',
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Tooltip(
                                                          message:
                                                              'Update you\'r comment',
                                                          child: ElevatedButton
                                                              .icon(
                                                            icon: Icon(
                                                              Icons
                                                                  .chat_bubble_outline,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              size: 17,
                                                            ),
                                                            label:
                                                                Text('Comment'),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              onPrimary: Theme.of(
                                                                              context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1
                                                                      .color
                                                                  : Colors
                                                                      .black,
                                                              primary: Theme.of(
                                                                      context)
                                                                  .scaffoldBackgroundColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        8.0),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                      },
                                                                      child:
                                                                          ListView(
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            BouncingScrollPhysics(),
                                                                        children: [
                                                                          ListTile(
                                                                            title:
                                                                                Text(
                                                                              'Add a comment',
                                                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          TextfieldWidget(
                                                                            maxLines:
                                                                                3,
                                                                            controller:
                                                                                viewModel.commentController,
                                                                            onSubmitted:
                                                                                (commentText) {
                                                                              if (viewModel.commentController.text.isNotEmpty) {
                                                                                Navigator.pop(context);
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 2), content: Text('Comments has been updated')));
                                                                                viewModel.addACommentToABook(commentString: commentText, tappedUserEmail: tappedUserEmail);
                                                                                viewModel.commentController.clear();
                                                                              } else {
                                                                                Navigator.pop(context);
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1), content: Text('Dismissed')));
                                                                                viewModel.commentController.clear();
                                                                              }
                                                                            },
                                                                          ),
                                                                          ElevatedButtonWidget(
                                                                            onPressed:
                                                                                () {
                                                                              if (viewModel.commentController.text.isNotEmpty) {
                                                                                Navigator.pop(context);
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 2), content: Text('Comments has been updated')));
                                                                                viewModel.addACommentToABook(commentString: viewModel.commentController.text, tappedUserEmail: tappedUserEmail);
                                                                                viewModel.commentController.clear();
                                                                              } else {
                                                                                Navigator.pop(context);
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1), content: Text('Dismissed')));
                                                                                viewModel.commentController.clear();
                                                                              }
                                                                            },
                                                                            text:
                                                                                'Update',
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                15,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  });
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Tooltip(
                                                          message:
                                                              'Add/update you\'r like',
                                                          child: ElevatedButton
                                                              .icon(
                                                            icon: FutureBuilder(
                                                              future: viewModel
                                                                  .getLikeBoolValue(
                                                                      bookId),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          DocumentSnapshot>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasError)
                                                                  return snapshot
                                                                      .error;
                                                                if (snapshot
                                                                        .data ==
                                                                    null) {
                                                                  return Container(
                                                                    height: 17,
                                                                    width: 17,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                }
                                                                if (!snapshot
                                                                    .data
                                                                    .exists) {
                                                                  return Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    size: 17,
                                                                  );
                                                                }
                                                                if (snapshot
                                                                        .hasData &&
                                                                    snapshot
                                                                        .data
                                                                        .exists) {
                                                                  bool isTrue;

                                                                  if (snapshot
                                                                          .data
                                                                          .data()['isReviewLiked'] !=
                                                                      null)
                                                                    isTrue = snapshot
                                                                            .data
                                                                            .data()[
                                                                        'isReviewLiked'];
                                                                  else
                                                                    isTrue =
                                                                        false;

                                                                  if (isTrue) {
                                                                    return Icon(
                                                                      Icons
                                                                          .favorite,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      size: 17,
                                                                    );
                                                                  }
                                                                  return Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: Theme.of(
                                                                            context)
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
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              onPrimary: Theme.of(
                                                                              context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1
                                                                      .color
                                                                  : Colors
                                                                      .black,
                                                              primary: Theme.of(
                                                                      context)
                                                                  .scaffoldBackgroundColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        8.0),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(SnackBar(
                                                                      duration: Duration(
                                                                          seconds:
                                                                              1),
                                                                      content: Text(
                                                                          'Like updated')));
                                                              viewModel.addAlikeToABook(
                                                                  tappedUserEmail:
                                                                      tappedUserEmail);
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    )
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
                              ),
                            ],
                          ),
                        ),
                        // ! comments
                        StreamBuilder(
                          stream: viewModel.getReviewComments(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.size == 0) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            colorFilter: new ColorFilter.mode(
                                                Colors.black.withOpacity(0.5),
                                                BlendMode.dstATop),
                                            image: NetworkImage(
                                              bookImage,
                                            ),
                                          ),
                                        ),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10,
                                              sigmaY: 10,
                                              tileMode: TileMode.clamp),
                                          child: Container(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? Colors.black.withOpacity(0.5)
                                                : Colors.white.withOpacity(0.5),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Tooltip(
                                                message: 'No Commnets yet ????',
                                                child: ListTile(
                                                  leading: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(),
                                                  ),
                                                  title: Text(
                                                      'No Commnets yet ????'),
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
                              return ListView(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  children:
                                      snapshot.data.docs.map<Widget>((doc) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                colorFilter:
                                                    new ColorFilter.mode(
                                                        Colors.black
                                                            .withOpacity(0.5),
                                                        BlendMode.dstATop),
                                                image: NetworkImage(
                                                  bookImage,
                                                ),
                                              ),
                                            ),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10,
                                                  sigmaY: 10,
                                                  tileMode: TileMode.clamp),
                                              child: Container(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                        .withOpacity(0.5)
                                                    : Colors.white
                                                        .withOpacity(0.5),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ListTile(
                                                    leading: GestureDetector(
                                                      onTap: () {
                                                        viewModel.pushUserReviewToProfileCommentView(
                                                            userImageComment: doc[
                                                                'userImageComment'],
                                                            userEmailComment: doc[
                                                                'userEmailComment']);
                                                      },
                                                      child: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    doc['userImageComment']))),
                                                      ),
                                                    ),
                                                    title: Text(
                                                        doc['userNameComment']),
                                                    subtitle: Text(
                                                        doc['userComment']),
                                                    trailing: Text(
                                                      DateFormat.jm().format(
                                                          doc['sendDate']
                                                              .toDate()),
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                        SizedBox(
                          height: 50,
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
