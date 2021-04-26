import 'package:boo_vi_app/widgets/dumb_widgets/information_tile/information_tile_widget.dart';
import 'package:boo_vi_app/widgets/dumb_widgets/list_tile/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'global_challenge_view_model.dart';

class GlobalChallengeView extends StatelessWidget {
  final String bookId;
  final String bookTitle;
  final String bookImage;
  final String bookAuthor;
  //
  final String challengeTitle;
  final String challengeDisc;
  final DateTime challengeDate;
  final int numberOfPeopleWhoHasCompletedThatChallenge;
  final int numberOfPeopleWhoHasNotCompletedThatChallenge;
  //
  //
  final String trophyName;
  final String trophyImage;
  final String trophyIcon;
  final String trophyDisc;
  //
  final int trophyCount;
  final int arrowUpCount;
  final int arrowDownCount;

  const GlobalChallengeView(
      {Key key,
      @required this.bookId,
      @required this.bookTitle,
      @required this.bookImage,
      @required this.challengeTitle,
      @required this.challengeDisc,
      @required this.challengeDate,
      @required this.numberOfPeopleWhoHasCompletedThatChallenge,
      @required this.numberOfPeopleWhoHasNotCompletedThatChallenge,
      @required this.trophyName,
      @required this.trophyImage,
      @required this.trophyIcon,
      @required this.trophyDisc,
      @required this.trophyCount,
      @required this.arrowUpCount,
      @required this.arrowDownCount,
      @required this.bookAuthor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GlobalChallengeViewModel>.reactive(
      builder:
          (BuildContext context, GlobalChallengeViewModel viewModel, Widget _) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text(
                              'Add What ?',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: ListTile(
                                leading: Icon(Icons.clear_all),
                                title: Text('Add book to a shelf'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: ListTile(
                                leading: Icon(Icons.timer),
                                title: Text('Add as a challenge'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text('Global Challenge'),
          ),
          body: SingleChildScrollView(
            //  scrollDirection: Axis.horizontal,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Hero(
                      tag: bookId,
                      child: Container(
                        height: 250,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(bookImage),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Tooltip(
                        message: bookTitle,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 25),
                          child: Text(
                            bookTitle.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // if (bookAuthor != 'No authors')
                              //   viewModel.pushBookAuthorGridView(
                              //       authorName: bookAuthor);
                            },
                            child: Tooltip(
                              message: bookAuthor,
                              child: Text(
                                bookAuthor,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(trophyCount.toInt().toString())
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(arrowUpCount.toInt().toString())
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    numberOfPeopleWhoHasNotCompletedThatChallenge
                                        .toInt()
                                        .toString())
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.alarm,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    numberOfPeopleWhoHasNotCompletedThatChallenge
                                        .toInt()
                                        .toString())
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.how_to_reg,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(numberOfPeopleWhoHasCompletedThatChallenge
                                    .toInt()
                                    .toString())
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'Challenge details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Card(
                      // color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 12, right: 12, bottom: 10),
                          child: Container(
                            child: Text(
                              challengeDisc.length > 180
                                  ? '     ' +
                                      challengeDisc
                                          .replaceAll(
                                              RegExp(r"<[^>]*>",
                                                  multiLine: true,
                                                  caseSensitive: true),
                                              '')
                                          .substring(0, 180) +
                                      '...'
                                  : challengeDisc,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => GlobalChallengeViewModel(),
    );
  }
}
