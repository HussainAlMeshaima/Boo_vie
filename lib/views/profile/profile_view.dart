import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/theme_grid/theme_grid_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (BuildContext context, ProfileViewModel viewModel, Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
              actions: [
                IconButton(
                  icon: Icon(Icons.palette),
                  onPressed: () {
                    return showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ThemeGridWidget();
                      },
                    );
                  },
                ),
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: [
                                ListTile(
                                  title: Text(
                                    'Settings',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                OutlinedButtonWidget(
                                    text: 'Log out',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 3),
                                          content: Text(
                                              'Long press the button to log out.'),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      Navigator.pop(context);
                                      viewModel.signOut(context);
                                    }),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          });
                    })
              ],
            ),
            body: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 40,
                ),
                FutureBuilder(
                  future: viewModel.getUserInformationDoc(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(snapshot.data.get('userImage')),
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                bottom: -5,
                                right: -5,
                                child: Container(
                                  height: 37,
                                  width: 37,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).primaryColor),
                                  child: Icon(
                                    Icons.edit,
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -40,
                                child: Text(snapshot.data.get('userName'),
                                    style: TextStyle(fontSize: 20)),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: Container(
                                height: 37,
                                width: 37,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context).primaryColor),
                                child: Icon(
                                  Icons.edit,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 55,
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 20, right: 20, bottom: 0),
                    child: FutureBuilder(
                      future: viewModel.getUserInformationDoc(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            height: 80,
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0,
                                    right: 5,
                                    left: 5.0,
                                    bottom: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Tooltip(
                                      message: 'Total compleated challenges is ' +
                                          snapshot.data[
                                                  'userTotalCompleatedChallenges']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.timer,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data[
                                                    'userTotalCompleatedChallenges']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total trophies is ' +
                                          snapshot.data['userTotalTrophies']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.emoji_events,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data['userTotalTrophies']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total points is ' +
                                          snapshot.data['userTotalPoints']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.radio_button_checked,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data['userTotalPoints']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total Communities is ' +
                                          snapshot.data['userTotalCommunities']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.group_work,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot
                                                .data['userTotalCommunities']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total books reviwed is ' +
                                          snapshot.data['numberOfBookReviwed']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.sms,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data['numberOfBookReviwed']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Total likes is ' +
                                          snapshot.data['userTotalLikes']
                                              .toString(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            snapshot.data['userTotalLikes']
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: 80,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: viewModel.getUserShelfsStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) return snapshot.error;

                      if (snapshot.hasData) {
                        if (snapshot.data.size == 0) {
                          return Container(
                            height: 200,
                            child: Center(
                                child: Text(
                                    'Seems Like you dont have any shelf yet 😭')),
                          );
                        }
                        if (snapshot.data.size != 0) {
                          List<QueryDocumentSnapshot> shelfsDocs =
                              snapshot.data.docs;

                          shelfsDocs.sort((a, b) {
                            int aInt =
                                a.get('createdDate').microsecondsSinceEpoch;
                            int bInt =
                                b.get('createdDate').microsecondsSinceEpoch;
                            return bInt.compareTo(aInt);
                          });

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: shelfsDocs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20.0, top: 15),
                                      child: Container(
                                        child: Text(
                                          shelfsDocs[index]['name'],
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    StreamBuilder(
                                        stream: viewModel
                                            .getUserBooksInThatShelfStream(
                                                shelfName:
                                                    shelfsDocs[index].id),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            List<QueryDocumentSnapshot>
                                                booksDocs = snapshot.data.docs;

                                            return ListView(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 228,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        snapshot.data.size,
                                                    itemBuilder:
                                                        (context, index) {
                                                      booksDocs.sort((a, b) {
                                                        int aInt = a
                                                            .get('openedDate')
                                                            .microsecondsSinceEpoch;
                                                        int bInt = b
                                                            .get('openedDate')
                                                            .microsecondsSinceEpoch;
                                                        return bInt
                                                            .compareTo(aInt);
                                                      });
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            viewModel.pushBookView(
                                                                authors: booksDocs[index]['authors'] !=
                                                                        null
                                                                    ? booksDocs[index][
                                                                        'authors']
                                                                    : ' ',
                                                                id: booksDocs[index][
                                                                        'id'] ??
                                                                    '',
                                                                image: booksDocs[index]
                                                                        [
                                                                        'thumbnail'] ??
                                                                    '',
                                                                bookTitle:
                                                                    booksDocs[index]['title'] ??
                                                                        '',
                                                                previewLink:
                                                                    booksDocs[index]
                                                                            ['previewLink'] ??
                                                                        '');
                                                          },
                                                          child: Container(
                                                            width: 125,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      .5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    booksDocs[
                                                                            index]
                                                                        [
                                                                        'thumbnail']),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 8),
                                                  child: Container(
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }

                                          return Container(
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }),
                                  ],
                                );
                              });
                        }
                      }
                      if (!snapshot.hasData) {
                        return Container(
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Container(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    })
              ],
            ));
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
