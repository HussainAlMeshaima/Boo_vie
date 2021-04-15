import 'package:boo_vi_app/widgets/smart_widgets/theme_grid/theme_grid_widget.dart';
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
                          return Container(
                            height: MediaQuery.of(context).size.height / 3,
                            child: Column(
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
                            ),
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
                GestureDetector(
                  onTap: () {},
                  child: FutureBuilder(
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
                          ],
                        );
                      }
                      return Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xffE7E7E7)
                                  : Color(0xff656565).withOpacity(0.4),
                        ),
                      );
                    },
                  ),
                ),
                Text(viewModel.displayedNameController.text,
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: Container(
                    height: 80,
                    child: Card(
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, right: 22, left: 12.0, bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ),
                FutureBuilder(
                  future: viewModel.getUserShelfFuture(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data['shelfs'].length,
                            itemBuilder: (context, index) {
                              return ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20.0, top: 12),
                                    child: Row(
                                      children: [
                                        Text(
                                          snapshot.data['shelfs'][index]
                                              ['shelfName'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 5),
                                          child: Container(
                                            height: 150,
                                            child: ListView(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: snapshot
                                                        .data['shelfs'][index]
                                                            ['books']
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 3,
                                                                horizontal: 7),
                                                        child: Container(
                                                          width: 85,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      .5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                        ),
                                                      );
                                                    }),
                                                GestureDetector(
                                                  onTap: () => viewModel
                                                      .pushSearchView(),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 3,
                                                        horizontal: 7),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        Positioned(
                                                          right: -13,
                                                          child: Container(
                                                            width: 85,
                                                            height: 120,
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        .3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: -7,
                                                          child: Container(
                                                            width: 85,
                                                            height: 133,
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        .6),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 85,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Container(
                                                            height: 140,
                                                            child: Icon(
                                                              Icons.add_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 30,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 15),
                                        child: Container(
                                          height: 11,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(.3)
                                                  : Theme.of(context).cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }

                    return Container(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
