import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'global_challenges_view_model.dart';

class GlobalChallengesWidget extends StatelessWidget {
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

  const GlobalChallengesWidget(
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
    return ViewModelBuilder<GlobalChallengesViewModel>.reactive(
      builder: (BuildContext context, GlobalChallengesViewModel viewModel,
          Widget _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => viewModel.pushGlobalChallengeView(),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 187,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Tooltip(
                          message: 'Book Image',
                          child: Hero(
                            tag: bookId,
                            child: Container(
                              height: 150,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.5),
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(bookImage))),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Tooltip(
                              message: challengeTitle,
                              child: Text(
                                challengeTitle.length > 16
                                    ? challengeTitle.substring(0, 16) + '..'
                                    : challengeTitle,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 205,
                              child: Tooltip(
                                message: challengeDisc,
                                child: Text(challengeDisc.length > 70
                                    ? challengeDisc.substring(0, 70) + '..'
                                    : challengeDisc),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Spacer(),
                            Container(
                              height: 50,
                              width: 200,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                color: Color(0xff2C2A2A),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Tooltip(
                                        message: 'Number Of trophies is ' +
                                            trophyCount.toInt().toString(),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.emoji_events,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text(
                                              trophyCount.toInt().toString(),
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      Tooltip(
                                        message: 'Number of push is ' +
                                            arrowUpCount.toInt().toString(),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.arrow_upward_rounded,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text(
                                              arrowUpCount.toInt().toString(),
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      Tooltip(
                                        message: 'Number of pull is ' +
                                            arrowDownCount.toInt().toString(),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.arrow_downward,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text(
                                              arrowDownCount.toInt().toString(),
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      Tooltip(
                                        message: 'Number of user done is ' +
                                            numberOfPeopleWhoHasCompletedThatChallenge
                                                .toInt()
                                                .toString(),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.how_to_reg,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text(
                                              numberOfPeopleWhoHasCompletedThatChallenge
                                                  .toInt()
                                                  .toString(),
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
        );
      },
      viewModelBuilder: () => GlobalChallengesViewModel(),
    );
  }
}
