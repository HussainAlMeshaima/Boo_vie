import 'package:boo_vi_app/widgets/smart_widgets/book_author_and_name/book_author_and_name_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/book_categories_row/book_categories_row_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/more_books/more_books_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: [
              IconButton(icon: Icon(Icons.emoji_events), onPressed: () {})
            ],
          ),
          body: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              FutureBuilder(
                future: viewModel.getUserCategories(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) return snapshot.error;

                  if (snapshot.hasData) {
                    Map userCategories = snapshot.data.data()['userCategories'];

                    List<String> keyList = [];
                    List<String> keyStings = [];
                    List<String> catigoryNameTrimed = [];

                    userCategories.forEach(
                      (key, value) {
                        if (value['isSelected']) {
                          print(value['isSelected']);

                          keyList.add(key);
                          keyStings.add(value['catigoryName']);
                          catigoryNameTrimed.add(value['catigoryNameTrimed']);
                        }
                      },
                    );

                    List<Stream> streamsList = [
                      viewModel.getArtsAndentErtainmentBooksStream(),
                      viewModel.getBiographiesAndMemoirsBooksStream(),
                    ];
                    List<Stream> fullStreamsList = [
                      viewModel.getFullArtsAndentErtainmentBooksStream(),
                      viewModel.getFullBiographiesAndMemoirsBooksStream(),
                    ];
                    List<int> indexOfStreams = [];
                    for (var item in catigoryNameTrimed) {
                      if (item == 'artsandentertainmentBooks')
                        indexOfStreams.add(1);
                      if (item == 'biographiesandmemoirsBooks')
                        indexOfStreams.add(2);
                    }
                    print(indexOfStreams);

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: keyStings.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: [
                              BookCategoriesRowWidget(
                                text: keyStings[index],
                              ),
                              Container(
                                height: 255,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: [
                                    StreamBuilder(
                                        stream: streamsList[index],
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasError)
                                            return snapshot.error;

                                          if (snapshot.hasData) {
                                            return Container(
                                              height: 255,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                children: snapshot.data.docs
                                                    .map<Widget>((document) {
                                                  return BookAuthorAndNameWidget(
                                                    context: context,
                                                    bookAuthor: document
                                                        .data()['authors'],
                                                    networkImage: document
                                                        .data()['medium'],
                                                    bookId:
                                                        document.data()['id'],
                                                    onTap: () =>
                                                        viewModel.pushBookView(
                                                      image: document
                                                          .data()['medium'],
                                                      id: document
                                                          .data()['id']
                                                          .replaceAll(
                                                              new RegExp(
                                                                  r".{/ +}"),
                                                              ''),
                                                      bookTitle: document
                                                          .data()['title'],
                                                      previewLink:
                                                          document.data()[
                                                              'previewLink'],
                                                    ),
                                                    bookTitle: document
                                                        .data()['title'],
                                                  );
                                                }).toList(),
                                              ),
                                            );
                                          }

                                          return Container(
                                              height: 250,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ));
                                        }),
                                    MoreBooksWidget(
                                      onTap: () => viewModel.pushMoreBooksView(
                                          stream: fullStreamsList[index],
                                          text: keyStings[index]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
