import 'dart:async';
import 'dart:ui';

import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
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
            body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text('My Global Challenge'),
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
            SliverList(
                delegate: SliverChildListDelegate([
              ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
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
                          tag: bookId,
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
                  !viewModel.isChallangeTimeDone
                      ? Container(
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
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
                                        viewModel.image,
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
                                          ? Colors.black.withOpacity(0.5)
                                          : Colors.white.withOpacity(0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  viewModel.numberOfdays
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 26),
                                                ),
                                                Text(
                                                  'DAYS',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .color
                                                          .withOpacity(.35)),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .color
                                                      .withOpacity(.7)),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  viewModel.numberOfhours
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 26),
                                                ),
                                                Text(
                                                  'HOUR',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .color
                                                          .withOpacity(.35)),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .color
                                                      .withOpacity(.7)),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  viewModel.numberOfminutes
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 26),
                                                ),
                                                Text(
                                                  'MIN',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .color
                                                          .withOpacity(.35)),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .color
                                                      .withOpacity(.7)),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  viewModel.numberOfseconds
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 26),
                                                ),
                                                Text(
                                                  'SEC',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .color
                                                          .withOpacity(.35)),
                                                ),
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
                        )
                      : Container(
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
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
                                        viewModel.image,
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
                                          ? Colors.red.withOpacity(0.5)
                                          : Colors.red.withOpacity(0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Center(
                                          child: Text(
                                            'Challenge dismissed 😭',
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
                  SizedBox(
                    height: 5,
                  ),
                  !viewModel.isChallangeTimeDone
                      ? ElevatedButtonWidget(
                          text: 'Mark as done',
                          onPressed: () {},
                        )
                      : ElevatedButtonWidget(
                          text: 'Mark as done',
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedButtonWidget(
                    text: 'Remove',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text(
                              'Long press the button to remove challange.'),
                        ),
                      );
                    },
                    onLongPress: () {
                      Navigator.pop(context);
                      viewModel.removeChallangeFromMyChallanges();
                    },
                  ),
                  SizedBox(
                    height: 10,
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
                          child: StreamBuilder(
                            stream: viewModel.getChallangeDocument(challangeId),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) return snapshot.error;

                              if (snapshot.hasData) {
                                if (snapshot.data['challengeRules'] == null ||
                                    snapshot.data['challengeRules'].length ==
                                        0) {
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                          'Rules are not set for this challange 🥳'),
                                    ),
                                  );
                                } else if (snapshot
                                            .data['challengeRules'].length !=
                                        0 &&
                                    snapshot.data['challengeRules'] != null) {
                                  List<dynamic> challengeRules =
                                      snapshot.data['challengeRules'];
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: challengeRules.length,
                                    itemBuilder: (context, index) {
                                      return Tooltip(
                                        message: challengeRules[index],
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
                                                    challengeRules[index],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        child: StreamBuilder(
                          stream: viewModel.getChallangeDocument(challangeId),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) return snapshot.error;

                            if (snapshot.hasData) {
                              if (snapshot.data['challengeDiscription'] ==
                                  null) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                        'Discription is not set for this challange 🥳'),
                                  ),
                                );
                              }
                              String challengeDiscription =
                                  snapshot.data['challengeDiscription'];

                              if (challengeDiscription != null) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child:
                                      Text('         ' + challengeDiscription),
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
            ]))
          ],
        ));
      },
      viewModelBuilder: () => UserGlobalChallengeViewModel(),
    );
  }
}
