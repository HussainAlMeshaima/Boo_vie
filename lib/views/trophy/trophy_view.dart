import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'trophy_view_model.dart';
import 'package:intl/intl.dart';

class TrophyView extends StatelessWidget {
  final String trophyTitle;
  final String trophyDescription;
  final Timestamp trophyReceivedDate;
  final bool isNormalTrophy;

  final String bookId;
  final String bookImage;
  final String previewLink;
  final String bookAuthors;

  const TrophyView({
    Key key,
    @required this.trophyTitle,
    @required this.trophyDescription,
    @required this.trophyReceivedDate,
    @required this.bookId,
    @required this.bookImage,
    @required this.previewLink,
    @required this.bookAuthors,
    @required this.isNormalTrophy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrophyViewModel>.reactive(
      onModelReady: (TrophyViewModel viewModel) => viewModel.handleStartUpLogic(
        trophyTitle: trophyTitle,
        trophyDescription: trophyDescription,
        trophyReceivedDate: trophyReceivedDate,
        bookId: bookId,
        bookImage: bookImage,
        previewLink: previewLink,
        bookAuthors: bookAuthors,
      ),
      builder: (BuildContext context, TrophyViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Trophy'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                SizedBox(
                  height: 24,
                ),
                Center(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: NetworkImage(Theme.of(context).brightness ==
                                Brightness.dark
                            ? 'https://firebasestorage.googleapis.com/v0/b/boovie-22ac7.appspot.com/o/assets%2FwelcomeToBooVi%2FwelcomeToBooViDark.png?alt=media&token=771822a7-1d88-4e96-958b-ea655a9209bc'
                            : 'https://firebasestorage.googleapis.com/v0/b/boovie-22ac7.appspot.com/o/assets%2FwelcomeToBooVi%2FwelcomeToBooViLight.png?alt=media&token=8c1c90a8-3cbb-40d6-bad7-13d3464a934a'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text(
                    'Trophy name',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 1,
                            child: Icon(
                              Icons.emoji_events,
                              size: 50,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Text(viewModel.trophyTitle,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text(
                    'Trophy Description',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Text('       ' + viewModel.trophyDescription,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text(
                    'Trophy obtain on',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Text(
                          '       ' +
                              'Date       ' +
                              DateFormat('dd-MM-yyyy')
                                  .format(viewModel.trophyReceivedDate.toDate())
                                  .toString() +
                              '\n' +
                              '       ' +
                              'Time       ' +
                              DateFormat('kk:mm:a')
                                  .format(viewModel.trophyReceivedDate.toDate())
                                  .toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text(
                    'Trophy type',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Text('       ' + 'Normal tropy',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => TrophyViewModel(),
    );
  }
}
