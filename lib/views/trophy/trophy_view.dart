import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'trophy_view_model.dart';
import 'package:intl/intl.dart';

class TrophyView extends StatelessWidget {
  final String docId;
  //--------------------------------------------------------
  final bool isNormalTrophy;
  final String trophyChallengeDiscription;
  final String trophyChallengeImage;
  final String trophyChallengeName;
  final List<dynamic> trophyChallengeRules;
  //--------------------------------------------------------
  final String trophyDescription;
  final Timestamp trophyReceivedDate;
  final String trophyTitle;
  //--------------------------------------------------------
  final String id;
  final String previewLink;
  final String title;

  const TrophyView(
      {Key key,
      @required this.docId,
      @required this.isNormalTrophy,
      @required this.trophyChallengeDiscription,
      @required this.trophyChallengeImage,
      @required this.trophyChallengeName,
      @required this.trophyChallengeRules,
      @required this.trophyDescription,
      @required this.trophyReceivedDate,
      @required this.trophyTitle,
      @required this.id,
      @required this.previewLink,
      @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrophyViewModel>.reactive(
      onModelReady: (TrophyViewModel viewModel) => viewModel.handleStartUpLogic(
        docId: docId,
        //--------------------------------------------------------
        isNormalTrophy: isNormalTrophy,
        trophyChallengeDiscription: trophyChallengeDiscription,
        trophyChallengeImage: trophyChallengeImage,
        trophyChallengeName: trophyChallengeName,
        trophyChallengeRules: trophyChallengeRules,
        //--------------------------------------------------------
        trophyDescription: trophyDescription,
        trophyReceivedDate: trophyReceivedDate,
        trophyTitle: trophyTitle,
        //--------------------------------------------------------
        id: id,
        previewLink: previewLink,
        title: title,
      ),
      builder: (BuildContext context, TrophyViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Trophy'),
          ),
          body: !viewModel.isNormalTrophy
              ? ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        // ignore: missing_required_param
                        viewModel.pushBookView(
                            id: viewModel.id,
                            image: viewModel.trophyChallengeImage,
                            previewLink: viewModel.previewLink);
                      },
                      child: Center(
                        child: Tooltip(
                          message: 'Book image',
                          child: Hero(
                            tag: viewModel.id,
                            child: Container(
                              height: 320,
                              width: 220,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(12),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: !viewModel.isNormalTrophy
                                      ? NetworkImage(
                                          viewModel.trophyChallengeImage)
                                      : NetworkImage(Theme.of(context)
                                                  .brightness ==
                                              Brightness.dark
                                          ? 'https://firebasestorage.googleapis.com/v0/b/boovie-22ac7.appspot.com/o/assets%2FwelcomeToBooVi%2FwelcomeToBooViDark.png?alt=media&token=771822a7-1d88-4e96-958b-ea655a9209bc'
                                          : 'https://firebasestorage.googleapis.com/v0/b/boovie-22ac7.appspot.com/o/assets%2FwelcomeToBooVi%2FwelcomeToBooViLight.png?alt=media&token=8c1c90a8-3cbb-40d6-bad7-13d3464a934a'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Trophy name',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Trophy name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: viewModel.trophyTitle,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('   ' + viewModel.trophyTitle,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Trophy type',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Trophy type',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: 'Book trophy',
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text('   ' + 'Book trophy',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Trophy description',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Trophy description',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: viewModel.trophyDescription,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text('   ' + viewModel.trophyDescription,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Challenge title',
                        child: Row(
                          children: [
                            Icon(Icons.timer,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Challenge title',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: viewModel.trophyChallengeName,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text('   ' + viewModel.trophyChallengeName,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Challenge rules',
                        child: Row(
                          children: [
                            Icon(Icons.timer,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Challenge rules',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: 'Rules: ' +
                              viewModel.trophyChallengeRules.join(', '),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      viewModel.trophyChallengeRules.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                          12.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Expanded(
                                              child: Text(
                                                viewModel.trophyChallengeRules[
                                                    index],
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Challenge description',
                        child: Row(
                          children: [
                            Icon(Icons.timer,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Challenge description',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: viewModel.trophyChallengeDiscription,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text(
                                  '   ' + viewModel.trophyChallengeDiscription,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Trophy obtain on',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Trophy obtain on',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: 'Date: ' +
                              DateFormat('dd-MM-yyyy')
                                  .format(viewModel.trophyReceivedDate.toDate())
                                  .toString() +
                              ', Time: ' +
                              DateFormat('kk:mm a')
                                  .format(viewModel.trophyReceivedDate.toDate())
                                  .toString(),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text(
                                  '   ' +
                                      'Date       ' +
                                      DateFormat('dd-MM-yyyy')
                                          .format(viewModel.trophyReceivedDate
                                              .toDate())
                                          .toString() +
                                      '\n' +
                                      '   ' +
                                      'Time       ' +
                                      DateFormat('kk:mm a')
                                          .format(viewModel.trophyReceivedDate
                                              .toDate())
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Total trophies earned',
                        child: Row(
                          children: [
                            Icon(
                              Icons.emoji_events,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Total trophies earned',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: '1',
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text('   ' + '1'.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                )
              : ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Hero(
                      tag: viewModel.docId,
                      child: Tooltip(
                        message: 'Welcome to BooVi image',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 230,
                            width: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(Theme.of(context)
                                            .brightness ==
                                        Brightness.dark
                                    ? 'https://firebasestorage.googleapis.com/v0/b/boovie-22ac7.appspot.com/o/assets%2FwelcomeToBooVi%2FwelcomeToBooViDark.png?alt=media&token=771822a7-1d88-4e96-958b-ea655a9209bc'
                                    : 'https://firebasestorage.googleapis.com/v0/b/boovie-22ac7.appspot.com/o/assets%2FwelcomeToBooVi%2FwelcomeToBooViLight.png?alt=media&token=8c1c90a8-3cbb-40d6-bad7-13d3464a934a'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Trophy name',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Trophy name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: viewModel.trophyTitle,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text('   ' + viewModel.trophyTitle,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Trophy type',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Trophy type',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: 'Normal trophy',
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text('   ' + 'Normal trophy',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Trophy description',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Trophy description',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: viewModel.trophyDescription,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text('   ' + viewModel.trophyDescription,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Trophy obtain on',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Trophy obtain on',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: 'Date: ' +
                              DateFormat('dd-MM-yyyy')
                                  .format(viewModel.trophyReceivedDate.toDate())
                                  .toString() +
                              ', Time: ' +
                              DateFormat('kk:mm a')
                                  .format(viewModel.trophyReceivedDate.toDate())
                                  .toString(),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text(
                                  '   ' +
                                      'Date       ' +
                                      DateFormat('dd-MM-yyyy')
                                          .format(viewModel.trophyReceivedDate
                                              .toDate())
                                          .toString() +
                                      '\n' +
                                      '   ' +
                                      'Time       ' +
                                      DateFormat('kk:mm a')
                                          .format(viewModel.trophyReceivedDate
                                              .toDate())
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Tooltip(
                        message: 'Total trophies earned',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Total trophies earned',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Tooltip(
                          message: '1',
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text('   ' + '1'.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
        );
      },
      viewModelBuilder: () => TrophyViewModel(),
    );
  }
}
