import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';
import 'community_challange_view_model.dart';

class CommunityChallangeView extends StatelessWidget {
  final String challangeType;
  final String challengeImage;
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

  const CommunityChallangeView({
    Key key,
    @required this.challangeType,
    @required this.previewLink,
    @required this.challengeName,
    @required this.challengeImage,
    @required this.challangeId,
    @required this.challengeDiscription,
    @required this.challengeRules,
    @required this.bookId,
    @required this.bookTitle,
    @required this.challengeAuthors,
    @required this.setToDate,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityChallangeViewModel>.reactive(
      onModelReady: (CommunityChallangeViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        challangeId: challangeId,
        bookId: bookId,
        challengeImage: challengeImage,
        challengeAuthors: challengeAuthors,
        challengeName: challengeName,
        previewLink: previewLink,
        bookTitle: bookTitle,
        setToDate: setToDate,
        challengeDiscription: challengeDiscription,
        challengeRules: challengeRules,
        challangeType: challangeType,
      ),
      builder: (BuildContext context, CommunityChallangeViewModel viewModel,
          Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text(challangeType ?? 'Challange'),
              actions: [
                Tooltip(
                  message: 'Share',
                  child: IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share(viewModel.previewLink ?? ' ',
                            subject: viewModel.challengeName ?? ' ');
                      }),
                ),
              ],
            ),
            body: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () => viewModel.pushBookView(),
                  child: Tooltip(
                    message: 'Book image',
                    child: Center(
                      child: Hero(
                        tag: viewModel.bookId,
                        child: Container(
                            height: 320,
                            width: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(viewModel.image)),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
      viewModelBuilder: () => CommunityChallangeViewModel(),
    );
  }
}
