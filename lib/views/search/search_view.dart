import 'package:boo_vi_app/widgets/smart_widgets/book_author_and_name/book_author_and_name_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/book_categories_row/book_categories_row_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/more_books/more_books_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'search_view_model.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (BuildContext context, SearchViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Search'),
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              TextfieldWidget(
                controller: viewModel.searchTextfieldController,
                hintText: 'Search',
                onPressedIcon: () =>
                    viewModel.pushSearchedView(context: context),
                iconData: Icons.send,
                onSubmitted: (String searchString) {
                  viewModel.pushSearchedView(context: context);
                },
              ),

              // ! Biographies Books
              BookCategoriesRowWidget(
                text: 'Biographies',
                onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullBiographiesAndMemoirsBooksStream(),
                    text: 'Biographies books'),
              ),
              Container(
                height: 255,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    StreamBuilder(
                        stream: viewModel.getBiographiesAndMemoirsBooksStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children:
                                    snapshot.data.docs.map<Widget>((document) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: document.data()['authors'],
                                    networkImage: document.data()['medium'],
                                    bookId: document.data()['id'],
                                    onTap: () => viewModel.pushBookView(
                                      image: document.data()['medium'],
                                      id: document.data()['id'].replaceAll(
                                          new RegExp(r".{/ +}"), ''),
                                      bookTitle: document.data()['title'],
                                      previewLink:
                                          document.data()['previewLink'],
                                    ),
                                    bookTitle: document.data()['title'],
                                  );
                                }).toList(),
                              ),
                            );
                          }

                          return Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        }),
                    MoreBooksWidget(
                      onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel
                              .getFullBiographiesAndMemoirsBooksStream(),
                          text: 'Biographies Books'),
                    ),
                  ],
                ),
              ),

              // ! Comic Books
              BookCategoriesRowWidget(
                text: 'Comic',
                onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getfullComicBooksStream(),
                    text: 'Comic books'),
              ),
              Container(
                height: 255,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    StreamBuilder(
                        stream: viewModel.getComicBooksStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children:
                                    snapshot.data.docs.map<Widget>((document) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: document.data()['authors'],
                                    networkImage: document.data()['medium'],
                                    bookId: document.data()['id'],
                                    onTap: () => viewModel.pushBookView(
                                      image: document.data()['medium'],
                                      id: document.data()['id'].replaceAll(
                                          new RegExp(r".{/ +}"), ''),
                                      bookTitle: document.data()['title'],
                                      previewLink:
                                          document.data()['previewLink'],
                                    ),
                                    bookTitle: document.data()['title'],
                                  );
                                }).toList(),
                              ),
                            );
                          }

                          return Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        }),
                    MoreBooksWidget(
                      onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel.getfullComicBooksStream(),
                          text: 'Comic Books'),
                    ),
                  ],
                ),
              ),

              // ! Entertainment Books
              BookCategoriesRowWidget(
                text: 'Art & entertainment',
                onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullArtsAndentErtainmentBooksStream(),
                    text: 'Art & entertainment books'),
              ),
              Container(
                height: 255,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    StreamBuilder(
                        stream: viewModel.getArtsAndentErtainmentBooksStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children:
                                    snapshot.data.docs.map<Widget>((document) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: document.data()['authors'],
                                    networkImage: document.data()['medium'],
                                    bookId: document.data()['id'],
                                    onTap: () => viewModel.pushBookView(
                                      image: document.data()['medium'],
                                      id: document.data()['id'].replaceAll(
                                          new RegExp(r".{/ +}"), ''),
                                      bookTitle: document.data()['title'],
                                      previewLink:
                                          document.data()['previewLink'],
                                    ),
                                    bookTitle: document.data()['title'],
                                  );
                                }).toList(),
                              ),
                            );
                          }

                          return Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        }),
                    MoreBooksWidget(
                      onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel
                              .getFullArtsAndentErtainmentBooksStream(),
                          text: 'Entertainment Books'),
                    ),
                  ],
                ),
              ),

              // ! Travel Books
              BookCategoriesRowWidget(
                text: 'Travel',
                onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getTravelBooksStream(),
                    text: 'Travel books'),
              ),
              Container(
                height: 255,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    StreamBuilder(
                        stream: viewModel.getTravelBooksStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children:
                                    snapshot.data.docs.map<Widget>((document) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: document.data()['authors'],
                                    networkImage: document.data()['medium'],
                                    bookId: document.data()['id'],
                                    onTap: () => viewModel.pushBookView(
                                      image: document.data()['medium'],
                                      id: document.data()['id'].replaceAll(
                                          new RegExp(r".{/ +}"), ''),
                                      bookTitle: document.data()['title'],
                                      previewLink:
                                          document.data()['previewLink'],
                                    ),
                                    bookTitle: document.data()['title'],
                                  );
                                }).toList(),
                              ),
                            );
                          }

                          return Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        }),
                    MoreBooksWidget(
                      onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel.getFullTravelBooksStream(),
                          text: 'Travel Books'),
                    ),
                  ],
                ),
              ),

              // ! History Books
              BookCategoriesRowWidget(
                text: 'History',
                onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullHistoryBooksStream(),
                    text: 'History Books'),
              ),
              Container(
                height: 255,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    StreamBuilder(
                        stream: viewModel.getHistoryBooksStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children:
                                    snapshot.data.docs.map<Widget>((document) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: document.data()['authors'],
                                    networkImage: document.data()['medium'],
                                    bookId: document.data()['id'],
                                    onTap: () => viewModel.pushBookView(
                                      image: document.data()['medium'],
                                      id: document.data()['id'].replaceAll(
                                          new RegExp(r".{/ +}"), ''),
                                      bookTitle: document.data()['title'],
                                      previewLink:
                                          document.data()['previewLink'],
                                    ),
                                    bookTitle: document.data()['title'],
                                  );
                                }).toList(),
                              ),
                            );
                          }

                          return Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        }),
                    MoreBooksWidget(
                      onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel.getFullHistoryBooksStream(),
                          text: 'History Books'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => SearchViewModel(),
    );
  }
}
