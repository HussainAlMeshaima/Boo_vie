import 'package:boo_vi_app/widgets/smart_widgets/comunity_cards/comunity_cards_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comunity_sheet_view_model.dart';

class ComunitySheetWidget extends StatelessWidget {
  final String bookId;
  final String bookTitle;
  final String challengeAuthors;
  final String challengeDiscription;
  final String challengeImage;
  final String challengeName;
  final String previewLink;

  const ComunitySheetWidget(
      {Key key,
      @required this.bookId,
      @required this.bookTitle,
      @required this.challengeAuthors,
      @required this.challengeDiscription,
      @required this.challengeImage,
      @required this.challengeName,
      @required this.previewLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunitySheetViewModel>.reactive(
      onModelReady: (ComunitySheetViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        bookId: bookId,
        bookTitle: bookTitle,
        challengeAuthors: challengeAuthors,
        challengeDiscription: challengeDiscription,
        challengeImage: challengeImage,
        challengeName: challengeName,
        previewLink: previewLink,
      ),
      builder:
          (BuildContext context, ComunitySheetViewModel viewModel, Widget _) {
        return ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            ListTile(
              title: Text(
                'My communities',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: viewModel.allCreatedComunities(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> comunitiesDocs =
                      snapshot.data.docs;

                  comunitiesDocs.removeWhere((QueryDocumentSnapshot comunity) =>
                      comunity['communityAdminEmail'] != viewModel.userEmail);

                  if (comunitiesDocs.isEmpty) {
                    return Container(
                      height: 250,
                      child: Center(
                        child: Text(
                            'Looks like you don\'t own any Communities 😭'),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: comunitiesDocs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ComunityCardsWidget(
                        member1Image: comunitiesDocs[index]['member1Image'],
                        member2Image: comunitiesDocs[index]['member2Image'],
                        numberOfChallenges: comunitiesDocs[index]
                            ['numberOfChallenges'],
                        docId: comunitiesDocs[index].id,
                        communityImage: comunitiesDocs[index]['communityImage'],
                        communityAdminImage: comunitiesDocs[index]
                            ['communityAdminImage'],
                        numberOfLikes: comunitiesDocs[index]['numberOfLikes'],
                        comunityName: comunitiesDocs[index]['comunityName'],
                        numberOfMembers: comunitiesDocs[index]
                            ['numberOfMembers'],
                        onTap: () async {
                          DateTime value = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(3000, 7),
                            helpText: 'Select a date',
                          );
                          if (value != null) {
                            viewModel.setBookAsAChallangeToThatComunity(
                              docId: comunitiesDocs[index].id,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text('Challange set !')));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text('Dismissed !')));
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        );
      },
      viewModelBuilder: () => ComunitySheetViewModel(),
    );
  }
}
