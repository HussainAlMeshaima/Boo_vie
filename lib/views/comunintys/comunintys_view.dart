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
              appBar: AppBar(
                title: Text('Comunintys'),
                bottom: TabBar(
                  //controller: viewModel,
                  //onTap: (int index) => viewModel.handleTapIndexChanged(index),
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(icon: Text('Comunitys')),
                    Tab(icon: Text('My Comunintys')),
                  ],
                ),
              ),
              body: PageView(
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).scaffoldBackgroundColor,
                              BlendMode.overlay),
                          child: Container(
                            height: 170,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    'https://i.pinimg.com/originals/37/81/ea/3781ea0fe6a39bc7bb9c088043cfc4dc.jpg')),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(Icons.person_rounded),
                                              Text('7'),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              Text(
                                                '7',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.emoji_events,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              Text(
                                                '7',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Comuninty 1',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Container(
                                          width: 196,
                                          child: Text(
                                            'Community is an American television sitcom created by Dan Harmon. The series ran  ..',
                                          ),
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                onPressed: () {},
                                                child: Text('view')),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                onPressed: () {},
                                                child: Text('Send request'))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        );
      },
      viewModelBuilder: () => ComunintysViewModel(),
    );
  }
}
