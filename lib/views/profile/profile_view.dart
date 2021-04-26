import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
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
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text(
                                  'Edit Profile',
                                ),
                              ),
                              // ListTile(
                              //   leading: Icon(Icons.clear_all),
                              //   title: Text(
                              //     'Add a shelf',
                              //   ),
                              //   onTap: () {
                              //     Navigator.pop(context);
                              //     showModalBottomSheet(
                              //         context: context,
                              //         builder: (context) {
                              //           return ListView(
                              //             shrinkWrap: true,
                              //             physics: ScrollPhysics(),
                              //             children: [
                              //               ListTile(
                              //                 title: Text(
                              //                   'Add a name to your new shelf:',
                              //                   style: TextStyle(
                              //                       fontSize: 20,
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //                 ),
                              //               ),
                              //               TextfieldWidget(
                              //                 maxLines: 5,
                              //                 controller: viewModel
                              //                     .newSelfNameController,
                              //                 onSubmitted: (String newString) {
                              //                   viewModel
                              //                       .submitNewSelfNameController(
                              //                           newString);
                              //                 },
                              //               ),
                              //             ],
                              //           );
                              //         });
                              //   },
                              // ),

                              ListTile(
                                leading: Icon(Icons.palette),
                                title: Text('Theme color'),
                                onTap: () {
                                  Navigator.pop(context);
                                  return showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ThemeGridWidget();
                                      });
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.logout),
                                title: Text('Log out'),
                                onTap: () {
                                  Navigator.pop(context);
                                  viewModel.signOut(context);
                                },
                              ),
                            ],
                          );
                        });
                  })
            ],
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 40,
                ),
                FutureBuilder(
                  future: viewModel.getUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Center(
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Color(0xffE7E7E7)
                                      : Color(0xff656565).withOpacity(0.4),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        snapshot.data.data()['userImage']),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(snapshot.data.data()['displayedName'],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                        ],
                      );
                    }
                    return Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xffE7E7E7)
                            : Color(0xff656565).withOpacity(0.4),
                      ),
                    );
                  },
                ),
                Text(viewModel.displayedNameController.text,
                    style: TextStyle(fontSize: 20)),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 20, right: 20, bottom: 10),
                    child: FutureBuilder(
                      future: viewModel.getUserDetails(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                                    right: 22,
                                    left: 12.0,
                                    bottom: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '-',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          'Avg. Rating',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '-',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          'Reviews',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '11',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          'Communities',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )),
                FutureBuilder(
                    future: viewModel.getUserShelfsFuture(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) return snapshot.error;

                      if (snapshot.hasData) {
                        if (snapshot.data.size == 0) {
                          return Container(
                            height: 200,
                            child: Center(
                                child: Text(
                                    'Seems Like you dont have any shelf yet😭')),
                          );
                        }
                        if (snapshot.data.size != 0) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data.size,
                              itemBuilder: (BuildContext context, int index) {
                                return ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20.0, top: 12),
                                      child: Container(
                                        child: Text(
                                          snapshot.data.docs[index]['name'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    StreamBuilder(
                                        stream: viewModel
                                            .getUserBooksInThatShelfStream(
                                                shelfName: snapshot
                                                    .data.docs[index].id),
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
                                                  height: 200,
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
                                                                id: booksDocs[
                                                                        index]
                                                                    ['id'],
                                                                image: booksDocs[
                                                                        index]
                                                                    [
                                                                    'thumbnail'],
                                                                bookTitle: booksDocs[
                                                                        index][
                                                                    'thumbnail'],
                                                                previewLink:
                                                                    booksDocs[
                                                                            index]
                                                                        [
                                                                        'previewLink']);
                                                          },
                                                          child: Hero(
                                                            tag:
                                                                booksDocs[index]
                                                                    ['id'],
                                                            child: Container(
                                                              height: 150,
                                                              width: 110,
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
                                                          .cardColor,
                                                    ),
                                                  ),
                                                )
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
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
