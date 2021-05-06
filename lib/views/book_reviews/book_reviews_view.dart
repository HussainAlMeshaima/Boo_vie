import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'book_reviews_view_model.dart';
import 'package:intl/intl.dart';

class BookReviewsView extends StatelessWidget {
  final String bookId;
  final String tappedUserEmail;

  const BookReviewsView(
      {Key key, @required this.bookId, @required this.tappedUserEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookReviewsViewModel>.reactive(
      onModelReady: (BookReviewsViewModel viewModel) =>
          viewModel.handleStartUpLogic(bookId),
      builder:
          (BuildContext context, BookReviewsViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Book Reviews'),
          ),
          body: StreamBuilder(
            stream: viewModel.getReviewsStream(bookId),
            builder: (context, snapshot) {
              if (snapshot.hasError) return snapshot.error;
              if (snapshot.hasData) {
                if (snapshot.data.docs.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          height: 87,
                          child: Center(
                            child: Text('No Book reviews yet ! 😭'),
                          ),
                        ),
                      ),
                    ),
                  );
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
                        children: snapshot.data.docs
                            .map<Widget>((DocumentSnapshot doc) {
                          int userReviewEmojiRating =
                              doc['userReviewEmojiRating'].toInt();
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

                          print(userReviewEmojiRating);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  doc['userImage'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  doc['userName'].length > 14
                                                      ? doc['userName']
                                                              .substring(
                                                                  0, 14) +
                                                          '..'
                                                      : doc['userName'],
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
                                                      doc['reviewDateTime']
                                                          .toDate()),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
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
                                            padding: const EdgeInsets.all(15.0),
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 230,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
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
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          doc['reviewCommentsConter']
                                                              .toInt()
                                                              .toString(),
                                                          style: TextStyle(
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
                                                          color:
                                                              Theme.of(context)
                                                                  .iconTheme
                                                                  .color,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Icon(
                                                          Icons.favorite_border,
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          doc['reviewLikeConter']
                                                              .toInt()
                                                              .toString(),
                                                          style: TextStyle(
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
                                                          color:
                                                              Theme.of(context)
                                                                  .iconTheme
                                                                  .color,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Icon(
                                                          Icons.schedule,
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          DateFormat('H:m a')
                                                              .format(doc[
                                                                      'reviewDateTime']
                                                                  .toDate()),
                                                          style: TextStyle(
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
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(doc['userReviewString']),
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
                                                    new BorderRadius.circular(
                                                        8.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            2.5,
                                                    child: ListView(
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                            'Add a comment',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        TextfieldWidget(
                                                          maxLines: 5,
                                                          //onSubmitted: ,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }

              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        );
      },
      viewModelBuilder: () => BookReviewsViewModel(),
    );
  }
}
