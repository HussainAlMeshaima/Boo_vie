import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'list_tile_re_view_model.dart';
import 'package:intl/intl.dart';

class ListTileReWidget extends StatelessWidget {
  final String userImage;
  final String userName;
  final String userReview;
  final DateTime userSentTime;
  final double commentsCounter;
  final double likesCounter;
  final String bookId;
  final String bookImage;

  const ListTileReWidget({
    Key key,
    @required this.userImage,
    @required this.userName,
    @required this.userReview,
    @required this.userSentTime,
    @required this.commentsCounter,
    @required this.likesCounter,
    @required this.bookId,
    @required this.bookImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListTileReViewModel>.reactive(
      onModelReady: (ListTileReViewModel viewModel) =>
          viewModel.handleStartUpLogic(bookId, bookImage),
      builder: (BuildContext context, ListTileReViewModel viewModel, Widget _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Container(
            height: 87,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: NetworkImage(
                        bookImage,
                      ),
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10, sigmaY: 10, tileMode: TileMode.clamp),
                    child: Container(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.5)
                          : Colors.white.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Tooltip(
                              message: userName + ' profile Image',
                              child: Container(
                                height: 43,
                                width: 43,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color(0xff262626)
                                        : Color(0xffE8E8E8),
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(userImage))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5),
                              child: Container(
                                width: 152,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Tooltip(
                                      message: userName,
                                      child: Text(
                                        userName.length > 11
                                            ? userName.substring(0, 13) + '..'
                                            : userName,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Tooltip(
                                      message: userReview,
                                      child: Text(
                                        userReview.length > 36
                                            ? userReview.substring(0, 36) + '..'
                                            : userReview,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  DateFormat.jm()
                                      .format(userSentTime)
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                Spacer(),
                                Container(
                                  height: 42,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.sms,
                                              size: 18,
                                            ),
                                            Text(
                                              commentsCounter
                                                  .toInt()
                                                  .toString(),
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              size: 18,
                                            ),
                                            Text(
                                              likesCounter.toInt().toString(),
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
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
            ),
          ),
        );
      },
      viewModelBuilder: () => ListTileReViewModel(),
    );
  }
}
