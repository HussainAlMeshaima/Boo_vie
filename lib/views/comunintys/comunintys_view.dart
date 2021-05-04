import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comunintys_view_model.dart';

class ComunintysView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunintysViewModel>.reactive(
      builder: (BuildContext context, ComunintysViewModel viewModel, Widget _) {
        return DefaultTabController(
          length: 3,
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
                    Tooltip(
                        message: 'Chats tab', child: Tab(icon: Text('Chats'))),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  // ! Global Comunintys
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.pushComunintyInformationView();
                        },
                        child: ListView(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Card(
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
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/80004f68741469.5bae1b8424f4c.jpg')),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 210,
                                            child: Text(
                                              'Hussain Comunity 101',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                size: 18,
                                              ),
                                              Text('19'),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                size: 18,
                                              ),
                                              Text('19'),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.people,
                                                size: 18,
                                              ),
                                              Text('19'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        '     Welcome to a community of Community fans, and the subreddit that\'s streets ahead! Voted 5th best new Reddit community of 2010 and 2nd best little Reddit '
                                                    .length >=
                                                150
                                            ? '     Welcome to a community of Community fans, and the subreddit that\'s streets ahead! Voted 5th best new Reddit community of 2010 and 2nd best little Reddit '
                                                    .substring(0, 150) +
                                                '...'
                                            : '     Welcome to a community of Community fans, and the subreddit that\'s streets ahead! Voted 5th best new Reddit community of 2010 and 2nd best little Reddit ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ! My Comunintys
                  Container(),

                  // !
                  StreamBuilder(
                    stream: viewModel.getPrivateChatWithOtherUsers(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ListView(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        viewModel.pushRoomView(
                                            otherUser:
                                                snapshot.data.docs[index].id);
                                      },
                                      child: ListTile(
                                        leading: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.4),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(snapshot
                                                  .data.docs[index]['image']),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          snapshot.data.docs[index]['name'],
                                        ),
                                        subtitle: Text(
                                          snapshot.data.docs[index]
                                              ['lastMessage'],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 25,
                                      ),
                                      child: Divider(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ]),
                            );
                          },
                        );
                      }
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  )
                ],
              )),
        );
      },
      viewModelBuilder: () => ComunintysViewModel(),
    );
  }
}
