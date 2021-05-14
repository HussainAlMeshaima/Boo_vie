import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comunity_cards_view_model.dart';

class ComunityCardsWidget extends StatelessWidget {
  final String docId;
  final int numberOfMembers;
  final int numberOfLikes;
  final int numberOfChallenges;
  final String communityAdminImage;
  final String communityImage;
  final String comunityName;
  final String member1Image;
  final String member2Image;

  final Function onTap;

  const ComunityCardsWidget(
      {Key key,
      @required this.docId,
      @required this.numberOfMembers,
      @required this.numberOfLikes,
      @required this.numberOfChallenges,
      @required this.communityAdminImage,
      @required this.onTap,
      @required this.communityImage,
      @required this.comunityName,
      @required this.member1Image,
      @required this.member2Image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunityCardsViewModel>.reactive(
      builder:
          (BuildContext context, ComunityCardsViewModel viewModel, Widget _) {
        return numberOfMembers == 0
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      GestureDetector(
                        onTap: onTap ?? {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            child: ListView(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        communityImage,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Positioned(
                                          bottom: -42,
                                          child: Container(
                                            height: 113,
                                            width: 300,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(9.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 260,
                                                          child: Text(
                                                            comunityName,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Stack(
                                                          clipBehavior:
                                                              Clip.none,
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .bottomEnd,
                                                          children: [
                                                            Hero(
                                                              tag: docId,
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Theme.of(context)
                                                                            .primaryColor
                                                                            .withOpacity(
                                                                                .4),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Theme.of(context).primaryColor.withOpacity(.4),
                                                                              blurRadius: 5,
                                                                              spreadRadius: 1)
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image: NetworkImage(communityAdminImage))),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 34,
                                                        ),
                                                        Spacer(),
                                                        Card(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          child: Container(
                                                            height: 36,
                                                            width: 75,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 5,
                                                                  vertical: 4),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .timer,
                                                                        size:
                                                                            16,
                                                                        color: Theme.of(context)
                                                                            .primaryIconTheme
                                                                            .color,
                                                                      ),
                                                                      Text(
                                                                        numberOfChallenges
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              9,
                                                                          color: Theme.of(context)
                                                                              .primaryIconTheme
                                                                              .color,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        size:
                                                                            16,
                                                                        color: Theme.of(context)
                                                                            .primaryIconTheme
                                                                            .color,
                                                                      ),
                                                                      Text(
                                                                        numberOfLikes
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              9,
                                                                          color: Theme.of(context)
                                                                              .primaryIconTheme
                                                                              .color,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .people,
                                                                        size:
                                                                            16,
                                                                        color: Theme.of(context)
                                                                            .primaryIconTheme
                                                                            .color,
                                                                      ),
                                                                      Text(
                                                                        numberOfMembers
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              9,
                                                                          color: Theme.of(context)
                                                                              .primaryIconTheme
                                                                              .color,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              )
            : numberOfMembers == 1
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          GestureDetector(
                            onTap: onTap ?? {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                child: ListView(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            communityImage,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Positioned(
                                              bottom: -42,
                                              child: Container(
                                                height: 113,
                                                width: 300,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 260,
                                                              child: Text(
                                                                comunityName,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .bottomEnd,
                                                              children: [
                                                                Positioned(
                                                                  right: -15,
                                                                  child:
                                                                      Container(
                                                                    height: 34,
                                                                    width: 34,
                                                                    decoration: BoxDecoration(
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Theme.of(context).primaryColor.withOpacity(.4),
                                                                              blurRadius: 5,
                                                                              spreadRadius: 1)
                                                                        ],
                                                                        color: Theme.of(context)
                                                                            .primaryColor
                                                                            .withOpacity(
                                                                                .4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                7),
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image: NetworkImage(member1Image))),
                                                                  ),
                                                                ),
                                                                Hero(
                                                                  tag: docId,
                                                                  child:
                                                                      Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    decoration: BoxDecoration(
                                                                        color: Theme.of(context).primaryColor.withOpacity(.4),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Theme.of(context).primaryColor.withOpacity(.4),
                                                                              blurRadius: 5,
                                                                              spreadRadius: 1)
                                                                        ],
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(communityAdminImage))),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 34,
                                                            ),
                                                            Spacer(),
                                                            Card(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              child: Container(
                                                                height: 36,
                                                                width: 75,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          5,
                                                                      vertical:
                                                                          4),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.timer,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                Theme.of(context).primaryIconTheme.color,
                                                                          ),
                                                                          Text(
                                                                            numberOfChallenges.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 9,
                                                                              color: Theme.of(context).primaryIconTheme.color,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.favorite,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                Theme.of(context).primaryIconTheme.color,
                                                                          ),
                                                                          Text(
                                                                            numberOfLikes.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 9,
                                                                              color: Theme.of(context).primaryIconTheme.color,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.people,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                Theme.of(context).primaryIconTheme.color,
                                                                          ),
                                                                          Text(
                                                                            numberOfMembers.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 9,
                                                                              color: Theme.of(context).primaryIconTheme.color,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  )
                : numberOfMembers == 2
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          child: ListView(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              GestureDetector(
                                onTap: onTap ?? {},
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    child: ListView(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                communityImage,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                Positioned(
                                                  bottom: -42,
                                                  child: Container(
                                                    height: 113,
                                                    width: 300,
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(9.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 260,
                                                                  child: Text(
                                                                    comunityName,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                              ],
                                                            ),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Stack(
                                                                  clipBehavior:
                                                                      Clip.none,
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .bottomEnd,
                                                                  children: [
                                                                    Positioned(
                                                                      right:
                                                                          -24,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            32,
                                                                        width:
                                                                            32,
                                                                        decoration: BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.4), blurRadius: 5, spreadRadius: 1)
                                                                            ],
                                                                            color:
                                                                                Theme.of(context).primaryColor.withOpacity(.4),
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(member2Image))),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      right:
                                                                          -15,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            34,
                                                                        width:
                                                                            34,
                                                                        decoration: BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.4), blurRadius: 5, spreadRadius: 1)
                                                                            ],
                                                                            color:
                                                                                Theme.of(context).primaryColor.withOpacity(.4),
                                                                            borderRadius: BorderRadius.circular(7),
                                                                            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(member1Image))),
                                                                      ),
                                                                    ),
                                                                    Hero(
                                                                      tag:
                                                                          docId,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            40,
                                                                        decoration: BoxDecoration(
                                                                            color: Theme.of(context).primaryColor.withOpacity(.4),
                                                                            boxShadow: [
                                                                              BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.4), blurRadius: 5, spreadRadius: 1)
                                                                            ],
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(communityAdminImage))),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 34,
                                                                ),
                                                                Spacer(),
                                                                Card(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  child:
                                                                      Container(
                                                                    height: 36,
                                                                    width: 75,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              4),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.timer,
                                                                                size: 16,
                                                                                color: Theme.of(context).primaryIconTheme.color,
                                                                              ),
                                                                              Text(
                                                                                numberOfChallenges.toString(),
                                                                                style: TextStyle(
                                                                                  fontSize: 9,
                                                                                  color: Theme.of(context).primaryIconTheme.color,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.favorite,
                                                                                size: 16,
                                                                                color: Theme.of(context).primaryIconTheme.color,
                                                                              ),
                                                                              Text(
                                                                                numberOfLikes.toString(),
                                                                                style: TextStyle(
                                                                                  fontSize: 9,
                                                                                  color: Theme.of(context).primaryIconTheme.color,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.people,
                                                                                size: 16,
                                                                                color: Theme.of(context).primaryIconTheme.color,
                                                                              ),
                                                                              Text(
                                                                                numberOfMembers.toString(),
                                                                                style: TextStyle(
                                                                                  fontSize: 9,
                                                                                  color: Theme.of(context).primaryIconTheme.color,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          child: ListView(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              GestureDetector(
                                onTap: onTap ?? {},
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    child: ListView(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                communityImage,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                Positioned(
                                                  bottom: -42,
                                                  child: Container(
                                                    height: 113,
                                                    width: 300,
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(9.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 260,
                                                                  child: Text(
                                                                    comunityName,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                              ],
                                                            ),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Stack(
                                                                  clipBehavior:
                                                                      Clip.none,
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .bottomEnd,
                                                                  children: [
                                                                    Positioned(
                                                                      right:
                                                                          -24,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            32,
                                                                        width:
                                                                            32,
                                                                        decoration: BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.4), blurRadius: 5, spreadRadius: 1)
                                                                            ],
                                                                            color:
                                                                                Theme.of(context).primaryColor.withOpacity(.4),
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage('https://thumbs.dreamstime.com/b/surprised-female-person-confused-isolated-surprised-female-person-confused-isolated-168304856.jpg'))),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      right:
                                                                          -15,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            34,
                                                                        width:
                                                                            34,
                                                                        decoration: BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.4), blurRadius: 5, spreadRadius: 1)
                                                                            ],
                                                                            color:
                                                                                Theme.of(context).primaryColor.withOpacity(.4),
                                                                            borderRadius: BorderRadius.circular(7),
                                                                            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage('https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'))),
                                                                      ),
                                                                    ),
                                                                    Hero(
                                                                      tag:
                                                                          docId,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            40,
                                                                        decoration: BoxDecoration(
                                                                            color: Theme.of(context).primaryColor.withOpacity(.4),
                                                                            boxShadow: [
                                                                              BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.4), blurRadius: 5, spreadRadius: 1)
                                                                            ],
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(communityAdminImage))),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 34,
                                                                ),
                                                                Text(
                                                                  (numberOfMembers -
                                                                          2)
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Text(
                                                                  ' more',
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                                Spacer(),
                                                                Card(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  child:
                                                                      Container(
                                                                    height: 36,
                                                                    width: 75,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              4),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.timer,
                                                                                size: 16,
                                                                                color: Theme.of(context).primaryIconTheme.color,
                                                                              ),
                                                                              Text(
                                                                                numberOfChallenges.toString(),
                                                                                style: TextStyle(
                                                                                  fontSize: 9,
                                                                                  color: Theme.of(context).primaryIconTheme.color,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.favorite,
                                                                                size: 16,
                                                                                color: Theme.of(context).primaryIconTheme.color,
                                                                              ),
                                                                              Text(
                                                                                numberOfLikes.toString(),
                                                                                style: TextStyle(
                                                                                  fontSize: 9,
                                                                                  color: Theme.of(context).primaryIconTheme.color,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.people,
                                                                                size: 16,
                                                                                color: Theme.of(context).primaryIconTheme.color,
                                                                              ),
                                                                              Text(
                                                                                numberOfMembers.toString(),
                                                                                style: TextStyle(
                                                                                  fontSize: 9,
                                                                                  color: Theme.of(context).primaryIconTheme.color,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      );
      },
      viewModelBuilder: () => ComunityCardsViewModel(),
    );
  }
}
