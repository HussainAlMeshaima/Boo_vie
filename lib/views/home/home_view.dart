import 'package:boo_vi_app/widgets/smart_widgets/currently_reading/currently_reading_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/book_author_and_name/book_author_and_name_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/book_categories_row/book_categories_row_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/more_books/more_books_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (
        BuildContext context,
        HomeViewModel viewModel,
        Widget _,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Home',
            ),
          ),
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: viewModel.getUserCurrentlyReadingBooksStream(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.isEmpty) {
                          return Container();
                        } else {
                          return ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: Row(children: [
                                    Tooltip(
                                      message: 'Currently Reading',
                                      child: Text(
                                        'Currently Reading',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ])),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 120,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return CurrentlyReadingWidget(
                                          numberOfTimesBookRead:
                                              snapshot.data.docs[index]
                                                  ['numberOfTimesBookRead'],
                                          bookPreviewLink: snapshot.data
                                              .docs[index]['bookPreviewLink'],
                                          bookId: snapshot.data.docs[index]
                                              ['bookId'],
                                          bookImage: snapshot.data.docs[index]
                                              ['bookImage'],
                                          bookAuthors: snapshot.data.docs[index]
                                              ['bookAuthors'],
                                          bookTitle: snapshot.data.docs[index]
                                              ['bookTitle'],
                                          bookTotalPages: snapshot.data
                                              .docs[index]['bookTotalPages'],
                                          bookCurrentlyReachedPages:
                                              snapshot.data.docs[index]
                                                  ['bookCurrentlyReachedPages'],
                                          elevatedButtonWidgetOnPressed: null,
                                          outlinedButtonWidgetOnPressed: null,
                                        );
                                      },
                                    )),
                              ),
                            ],
                          );
                        }
                      }
                      return Container();
                    },
                  ),
                  FutureBuilder(
                    future: viewModel.getUserCategories(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot,
                    ) {
                      if (snapshot.hasError) return snapshot.error;

                      if (snapshot.hasData) {
                        Map userCategories =
                            snapshot.data.data()['userCategories'] ?? {};

                        List<String> keys = [];
                        List<String> catigoryName = [];
                        List<String> catigoryNameTrimed = [];
                        List<Stream> emptyStreamsList = [];
                        List<Stream> emptyFullStreamsList = [];

                        userCategories.forEach(
                          (key, value) {
                            if (value['isSelected']) {
                              switch (key) {
                                case 'artsandentertainmentBooks':
                                  emptyStreamsList.add(
                                    viewModel
                                        .getArtsAndentErtainmentBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel
                                        .getFullArtsAndentErtainmentBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'biographiesandmemoirsBooks':
                                  emptyStreamsList.add(
                                    viewModel
                                        .getBiographiesAndMemoirsBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel
                                        .getFullBiographiesAndMemoirsBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'childrensbooksBooks':
                                  emptyStreamsList.add(
                                    viewModel.getChildrensBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel.getFullChildrensBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'comicsBooks':
                                  emptyStreamsList.add(
                                    viewModel.getComicBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel.getFullComicBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'computersandtechnologyBooks':
                                  emptyStreamsList.add(
                                    viewModel
                                        .getComputersAndTechnologyBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel
                                        .getFullComputersAndTechnologyBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'cookingandfoodBooks':
                                  emptyStreamsList.add(
                                    viewModel.getCookingAndFoodBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel
                                        .getFullCookingAndFoodBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'fictionandliteratureBooks':
                                  emptyStreamsList.add(
                                    viewModel
                                        .getFictionAndLiteratureBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel
                                        .getFullFictionAndLiteratureBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'healthmindandbodyBooks':
                                  emptyStreamsList.add(
                                    viewModel.getHealthMindAndbodyBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel
                                        .getFullHealthMindAndbodyBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'historyBooks':
                                  emptyStreamsList.add(
                                    viewModel.getHistoryBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel.getFullHistoryBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'homeandgardenBooks':
                                  emptyStreamsList.add(
                                    viewModel.getHomeAndGardenBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel.getFullHomeAndGardenBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'mysteryandthrillersBooks':
                                  emptyStreamsList.add(
                                    viewModel
                                        .getMysteryAndThrillersBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel
                                        .getFullMysteryAndThrillersBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'sciencefictionandfantasyBooks':
                                  emptyStreamsList.add(
                                    viewModel
                                        .getScienceFictionAndFantasyBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel
                                        .getFullScienceFictionAndFantasyBooksStream(),
                                  );
                                  keys.add(
                                    key,
                                  );
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'sportsBooks':
                                  emptyStreamsList.add(
                                    viewModel.getSportsBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel.getFullSportsBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                                case 'travelBooks':
                                  emptyStreamsList.add(
                                    viewModel.getTravelBooksStream(),
                                  );
                                  emptyFullStreamsList.add(
                                    viewModel.getFullTravelBooksStream(),
                                  );
                                  keys.add(key);
                                  catigoryName.add(
                                    value['catigoryName'],
                                  );
                                  catigoryNameTrimed.add(
                                    value['catigoryNameTrimed'],
                                  );
                                  break;
                              }
                            }
                          },
                        );

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: emptyStreamsList.length,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return ListView(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              children: [
                                BookCategoriesRowWidget(
                                  text: catigoryName[index],
                                  onPressed: () => viewModel.pushMoreBooksView(
                                    stream: emptyFullStreamsList[index],
                                    text: catigoryName[index],
                                  ),
                                ),
                                Container(
                                  height: 255,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    children: [
                                      StreamBuilder(
                                          stream: emptyStreamsList[index],
                                          builder: (
                                            BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot,
                                          ) {
                                            if (snapshot.hasError)
                                              return snapshot.error;

                                            if (snapshot.hasData) {
                                              return Container(
                                                height: 255,
                                                child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  children: snapshot.data.docs
                                                      .map<Widget>((document) {
                                                    return Tooltip(
                                                      message: document
                                                              .data()['title'] +
                                                          ' Book',
                                                      child:
                                                          BookAuthorAndNameWidget(
                                                        context: context,
                                                        bookAuthor: document
                                                            .data()['authors'],
                                                        networkImage: document
                                                            .data()['medium'],
                                                        bookId: document
                                                            .data()['id'],
                                                        onTap: () {
                                                          viewModel
                                                              .pushBookView(
                                                            authors:
                                                                document.data()[
                                                                    'authors'],
                                                            image:
                                                                document.data()[
                                                                    'medium'],
                                                            id: document
                                                                .data()['id']
                                                                .replaceAll(
                                                                  new RegExp(
                                                                    r".{/ +}",
                                                                  ),
                                                                  '',
                                                                ),
                                                            bookTitle:
                                                                document.data()[
                                                                    'title'],
                                                            previewLink: document
                                                                    .data()[
                                                                'previewLink'],
                                                          );
                                                          viewModel
                                                              .addAbookToRecentlyViewedShelf(
                                                            authors: document
                                                                        .data()[
                                                                    'authors'] ??
                                                                'No authors',
                                                            title:
                                                                document.data()[
                                                                    'title'],
                                                            bookImage:
                                                                document.data()[
                                                                    'medium'],
                                                            previewLink: document
                                                                    .data()[
                                                                'previewLink'],
                                                            bookId: document
                                                                .data()['id']
                                                                .replaceAll(
                                                                  new RegExp(
                                                                    r".{/ +}",
                                                                  ),
                                                                  '',
                                                                ),
                                                          );
                                                        },
                                                        bookTitle: document
                                                            .data()['title'],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              );
                                            }

                                            return Container(
                                                height: 250,
                                                width: MediaQuery.of(
                                                  context,
                                                ).size.width,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ));
                                          }),
                                      Tooltip(
                                        message: 'More ' + catigoryName[index],
                                        child: MoreBooksWidget(
                                          onTap: () =>
                                              viewModel.pushMoreBooksView(
                                            stream: emptyFullStreamsList[index],
                                            text: catigoryName[index],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  )
                ],
              )),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
