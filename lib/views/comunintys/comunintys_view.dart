import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comunintys_view_model.dart';

class ComunintysView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunintysViewModel>.reactive(
      builder: (BuildContext context, ComunintysViewModel viewModel, Widget _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  return showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: [
                            ListTile(
                              title: Text(
                                'Create What ?',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 5),
                              child: ListTile(
                                leading: Icon(
                                  Icons.group_work,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text('Create a Comuninty'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 5),
                              child: ListTile(
                                leading: Icon(
                                  Icons.sms,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text('Create a conversation'),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      });
                },
                child: Icon(Icons.add),
              ),
              appBar: AppBar(
                title: Tooltip(
                    message: 'Comunintys tab', child: Text('Comunintys')),
                actions: [
                  IconButton(icon: Icon(Icons.notifications), onPressed: () {})
                ],
                bottom: TabBar(
                  tabs: [
                    Tooltip(
                        message: 'Global Comunintys challenges',
                        child: Tab(
                            icon: Text(
                          'Global',
                          textAlign: TextAlign.center,
                        ))),
                    Tooltip(
                        message: 'My Comunintys tab',
                        child: Tab(
                            icon: Text(
                          'Comunintys',
                          textAlign: TextAlign.center,
                        ))),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  // ! Global Comunintys
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          InkWell(
                            onTap: () {
                              viewModel.pushComunintyInformationView();
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                child: ListView(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    Hero(
                                      tag: 1,
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/80004f68741469.5bae1b8424f4c.jpg')),
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
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 215,
                                                                child: Text(
                                                                  'Horror Comunity',
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
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Icon(
                                                                    Icons.timer,
                                                                    size: 20,
                                                                  ),
                                                                  Text(
                                                                    '12',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .people,
                                                                    size: 20,
                                                                  ),
                                                                  Text(
                                                                    '12',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
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
                                                                    right: -24,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          32,
                                                                      width: 32,
                                                                      decoration: BoxDecoration(
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                color: Colors.black45,
                                                                                blurRadius: 3,
                                                                                spreadRadius: 2)
                                                                          ],
                                                                          color: Theme.of(context).primaryColor.withOpacity(
                                                                              .4),
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: NetworkImage('https://thumbs.dreamstime.com/b/surprised-female-person-confused-isolated-surprised-female-person-confused-isolated-168304856.jpg'))),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    right: -15,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          34,
                                                                      width: 34,
                                                                      decoration: BoxDecoration(
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                color: Colors.black45,
                                                                                blurRadius: 3,
                                                                                spreadRadius: 2)
                                                                          ],
                                                                          color: Theme.of(context).primaryColor.withOpacity(
                                                                              .4),
                                                                          borderRadius: BorderRadius.circular(
                                                                              7),
                                                                          image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: NetworkImage('https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'))),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    decoration: BoxDecoration(
                                                                        color: Theme.of(context)
                                                                            .primaryColor
                                                                            .withOpacity(
                                                                                .4),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.black45,
                                                                              blurRadius: 3,
                                                                              spreadRadius: 2)
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image: NetworkImage('https://img.freepik.com/free-photo/cheerful-curly-business-girl-wearing-glasses_176420-206.jpg?size=626&ext=jpg'))),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 34,
                                                              ),
                                                              Text(
                                                                '12',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Text(
                                                                ' more',
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    fontSize:
                                                                        9),
                                                              ),
                                                              SizedBox(
                                                                width: 50,
                                                              ),
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
                  ),

                  // ! My Comunintys
                  Container(),
                ],
              )),
        );
      },
      viewModelBuilder: () => ComunintysViewModel(),
    );
  }
}
