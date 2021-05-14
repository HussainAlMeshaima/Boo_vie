import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comunity_active_challenges_view_model.dart';

class ComunityActiveChallengesView extends StatelessWidget {
  final String docId;

  const ComunityActiveChallengesView({Key key, @required this.docId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunityActiveChallengesViewModel>.reactive(
      onModelReady: (ComunityActiveChallengesViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        docId: docId,
      ),
      builder: (BuildContext context,
          ComunityActiveChallengesViewModel viewModel, Widget _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                title: Text('Challenges'),
                bottom: TabBar(
                  tabs: [
                    Tooltip(
                        message: 'Active challenges tab',
                        child: Tab(
                            icon: Text(
                          'Active challenges',
                          textAlign: TextAlign.center,
                        ))),
                    Tooltip(
                      message: 'History challenges tab',
                      child: Tab(
                        icon: Text(
                          'History challenges',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Container(
                      child: StreamBuilder(
                    stream: viewModel.getCommunityActiveChallanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  height: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://i.pinimg.com/originals/89/32/a4/8932a45b9660dd828bf53096c2776132.jpg'),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                            tileMode: TileMode.repeated,
                                          ),
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black45,
                                                    BlendMode.darken),
                                                image: NetworkImage(
                                                    'https://i.pinimg.com/originals/89/32/a4/8932a45b9660dd828bf53096c2776132.jpg'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 5, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'sdasd asdasda sda sdasdasdds dasda ashd ajhds ashd kjashd aas',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        'adasda',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Icon(Icons.remove),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return Container(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    },
                  )),
                  Container(
                      child: StreamBuilder(
                    stream: viewModel.getCommunityHistoryChallanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  height: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://i.pinimg.com/originals/89/32/a4/8932a45b9660dd828bf53096c2776132.jpg'),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                            tileMode: TileMode.repeated,
                                          ),
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black45,
                                                    BlendMode.darken),
                                                image: NetworkImage(
                                                    'https://i.pinimg.com/originals/89/32/a4/8932a45b9660dd828bf53096c2776132.jpg'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 5, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'sdasd asdasda sda sdasdasdds dasda ashd ajhds ashd kjashd aas',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        'adasda',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Icon(Icons.remove),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return Container(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    },
                  )),
                ],
              )),
        );
      },
      viewModelBuilder: () => ComunityActiveChallengesViewModel(),
    );
  }
}
