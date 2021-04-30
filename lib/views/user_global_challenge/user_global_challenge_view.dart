import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';
import 'user_global_challenge_view_model.dart';

class UserGlobalChallengeView extends StatelessWidget {
  final String challengeimage;
  final String challangeId;
  final String challengeDiscription;
  final List challengeRules;
  //-----------------------------------
  final String bookId;
  final String previewLink;
  final String bookTitle;
  final String challengeName;
  final String challengeAuthors;
  //-----------------------------------
  final Timestamp setToDate;
  final Map trophiesMap;

  const UserGlobalChallengeView(
      {Key key,
      this.challengeimage,
      this.challangeId,
      this.challengeDiscription,
      this.challengeRules,
      this.bookId,
      this.previewLink,
      this.bookTitle,
      this.challengeName,
      this.challengeAuthors,
      this.setToDate,
      this.trophiesMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserGlobalChallengeViewModel>.reactive(
      onModelReady: (UserGlobalChallengeViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        challangeId: challangeId,
        bookId: bookId,
        challengeImage: challengeimage,
        challengeAuthors: challengeAuthors,
        challengeName: challengeName,
        previewLink: previewLink,
        bookTitle: bookTitle,
        setToDate: setToDate,
        challengeDiscription: challengeDiscription,
        trophiesMap: trophiesMap,
        challengeRules: challengeRules,
      ),
      builder: (BuildContext context, UserGlobalChallengeViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Global Challenge'),
            actions: [
              Tooltip(
                message: 'Share',
                child: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      Share.share(viewModel.previewLink,
                          subject: viewModel.challengeName);
                    }),
              ),
            ],
          ),
          body: Center(
            child: Text('UserGlobalChallenge View'),
          ),
        );
      },
      viewModelBuilder: () => UserGlobalChallengeViewModel(),
    );
  }
}
