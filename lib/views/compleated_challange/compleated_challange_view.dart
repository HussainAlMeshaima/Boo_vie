import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'compleated_challange_view_model.dart';

class CompleatedChallangeView extends StatelessWidget {
  final String bookId;
  final String bookTitle;
  final String challengeAuthorName;
  final String challengeDiscription;
  final String challengeImage;
  final List challengeRules;
  final Timestamp completedDate;
  final String previewLink;
  final String challengeId;

  const CompleatedChallangeView({
    Key key,
    @required this.bookId,
    @required this.bookTitle,
    @required this.challengeAuthorName,
    @required this.challengeDiscription,
    @required this.challengeImage,
    @required this.challengeRules,
    @required this.completedDate,
    @required this.previewLink,
    @required this.challengeId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompleatedChallangeViewModel>.reactive(
      onModelReady: (CompleatedChallangeViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        bookId: bookId,
        bookTitle: bookTitle,
        challengeAuthorName: challengeAuthorName,
        challengeDiscription: challengeDiscription,
        challengeImage: challengeImage,
        challengeRules: challengeRules,
        completedDate: completedDate,
        previewLink: previewLink,
        challengeId: challengeId,
      ),
      builder: (BuildContext context, CompleatedChallangeViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Compleated Challange'),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
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
                                  image:
                                      NetworkImage(viewModel.challengeImage)),
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Tooltip(
                      message: 'Challenge Compleated 😊',
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.dstATop),
                                image: NetworkImage(
                                  viewModel.challengeImage,
                                ),
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                  tileMode: TileMode.clamp),
                              child: Container(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.green.withOpacity(0.5)
                                    : Colors.green.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Center(
                                    child: Text(
                                      'Challenge Compleated 😊',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
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
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Tooltip(
                        message: 'Challenge Rules',
                        child: Text(
                          'Rules',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: viewModel.challengeRules.length,
                            itemBuilder: (context, index) {
                              return Tooltip(
                                message: viewModel.challengeRules[index],
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Expanded(
                                          child: Text(
                                            viewModel.challengeRules[index],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Tooltip(
                        message: 'Challenge Description',
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                viewModel.challengeDiscription != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                              child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(viewModel.challengeDiscription)),
                          )),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                              child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                    'Discription is not set for this challange 🥳')),
                          )),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 3,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Tooltip(
                        message: 'Challenge Comments',
                        child: Text(
                          'Comments',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        0.0,
                      ),
                      child: StreamBuilder(
                        stream: viewModel.getChallangeComments(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot,
                        ) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0 ||
                                snapshot.data.docs == null ||
                                snapshot.data.docs.isEmpty) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(),
                                  ),
                                  title: Text(
                                    'No Commnets yet 😭',
                                  ),
                                ),
                              );
                            } else {
                              List<QueryDocumentSnapshot> docs =
                                  snapshot.data.docs;

                              docs.sort(
                                (a, b) {
                                  int aInt =
                                      a.get('sendDate').microsecondsSinceEpoch;
                                  int bInt =
                                      b.get('sendDate').microsecondsSinceEpoch;
                                  return aInt.compareTo(
                                    bInt,
                                  );
                                },
                              );

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ListTile(
                                        leading: GestureDetector(
                                          onTap: () {
                                            viewModel
                                                .pushUserReviewToProfileCommentView(
                                                    userImageComment: docs[
                                                            index]
                                                        ['userImageComment'],
                                                    userEmailComment: docs[
                                                            index]
                                                        ['userEmailComment']);
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(docs[
                                                            index]
                                                        ['userImageComment']))),
                                          ),
                                        ),
                                        title: Text(
                                            docs[index]['userNameComment']),
                                        subtitle:
                                            Text(docs[index]['userComment']),
                                        trailing: Text(
                                          DateFormat.jm().format(
                                              docs[index]['sendDate'].toDate()),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }

                          return Container(
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
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
      viewModelBuilder: () => CompleatedChallangeViewModel(),
    );
  }
}
