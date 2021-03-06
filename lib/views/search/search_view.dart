import 'package:boo_vi_app/widgets/smart_widgets/book_author_and_name/book_author_and_name_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/book_categories_row/book_categories_row_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/more_books/more_books_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'search_view_model.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (
        BuildContext context,
        SearchViewModel viewModel,
        Widget _,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                TextfieldWidget(
                  controller: viewModel.searchTextfieldController,
                  hintText: 'Search',
                  onPressedIcon: () {
                    viewModel.searchTextfieldController.text.trim();
                    viewModel.searchTextfieldController.text
                        .trim()
                        .replaceAll('', '+');

                    if (viewModel.searchTextfieldController.text.isNotEmpty) {
                      viewModel.pushSearchedView(context: context);
                      viewModel.searchTextfieldController.clear();
                      FocusScope.of(context).unfocus();
                    } else
                      return ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Search cannot be empty',
                          ),
                        ),
                      );
                  },
                  iconData: Icons.send,
                  onSubmitted: (
                    String searchString,
                  ) {
                    viewModel.searchTextfieldController.text.trim();
                    viewModel.searchTextfieldController.text.trim().replaceAll(
                          '',
                          '+',
                        );
                    print(
                      viewModel.searchTextfieldController.text + '---',
                    );
                    if (viewModel.searchTextfieldController.text.isNotEmpty) {
                      viewModel.pushSearchedView(context: context);
                      viewModel.searchTextfieldController.clear();
                      FocusScope.of(context).unfocus();
                    } else
                      return ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text('Search cannot be empty'),
                        ),
                      );
                  },
                ),

                // ! ArtsAndentErtainmentBooks
                BookCategoriesRowWidget(
                  text: 'Arts & Entertainment',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullArtsAndentErtainmentBooksStream(),
                    text: 'Arts & Entertainment',
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
                        stream: viewModel.getArtsAndentErtainmentBooksStream(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot,
                        ) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: snapshot.data.docs[index]
                                        ['authors'],
                                    networkImage: snapshot.data.docs[index]
                                        ['medium'],
                                    bookId: snapshot.data.docs[index]['id'],
                                    onTap: () {
                                      viewModel.pushBookView(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        image: snapshot.data.docs[index]
                                            ['medium'],
                                        id: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                        bookTitle: snapshot.data.docs[index]
                                            ['title'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                      );
                                      viewModel.addAbookToRecentlyViewedShelf(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        title: snapshot.data.docs[index]
                                            ['title'],
                                        bookImage: snapshot.data.docs[index]
                                            ['medium'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                        bookId: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                      );
                                    },
                                    bookTitle: snapshot.data.docs[index]
                                        ['title'],
                                  );
                                },
                              ),
                            );
                          }

                          return Container(
                            height: 250,
                            width: MediaQuery.of(
                              context,
                            ).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      MoreBooksWidget(
                        onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel
                              .getFullArtsAndentErtainmentBooksStream(),
                          text: 'Arts & Entertainment',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Biographies Books
                BookCategoriesRowWidget(
                  text: 'Biographies & memoirs',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullBiographiesAndMemoirsBooksStream(),
                    text: 'Biographies books',
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
                          stream:
                              viewModel.getBiographiesAndMemoirsBooksStream(),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snapshot,
                          ) {
                            if (snapshot.hasError) return snapshot.error;

                            if (snapshot.hasData) {
                              return Container(
                                height: 255,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return BookAuthorAndNameWidget(
                                      context: context,
                                      bookAuthor: snapshot.data.docs[index]
                                          ['authors'],
                                      networkImage: snapshot.data.docs[index]
                                          ['medium'],
                                      bookId: snapshot.data.docs[index]['id'],
                                      onTap: () {
                                        viewModel.pushBookView(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          image: snapshot.data.docs[index]
                                              ['medium'],
                                          id: snapshot.data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                          bookTitle: snapshot.data.docs[index]
                                              ['title'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                        );
                                        viewModel.addAbookToRecentlyViewedShelf(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          title: snapshot.data.docs[index]
                                              ['title'],
                                          bookImage: snapshot.data.docs[index]
                                              ['medium'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                          bookId: snapshot
                                              .data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                        );
                                      },
                                      bookTitle: snapshot.data.docs[index]
                                          ['title'],
                                    );
                                  },
                                ),
                              );
                            }

                            return Container(
                                height: 250,
                                width: MediaQuery.of(
                                  context,
                                ).size.width,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ));
                          }),
                      MoreBooksWidget(
                        onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel
                              .getFullBiographiesAndMemoirsBooksStream(),
                          text: 'Biographies Books',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Childrens Books
                BookCategoriesRowWidget(
                  text: 'Children\'s Books',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullChildrensBooksStream(),
                    text: 'Children\'s Books',
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
                        stream: viewModel.getChildrensBooksStream(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                        ) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: snapshot.data.docs[index]
                                        ['authors'],
                                    networkImage: snapshot.data.docs[index]
                                        ['medium'],
                                    bookId: snapshot.data.docs[index]['id'],
                                    onTap: () {
                                      viewModel.pushBookView(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        image: snapshot.data.docs[index]
                                            ['medium'],
                                        id: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                        bookTitle: snapshot.data.docs[index]
                                            ['title'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                      );
                                      viewModel.addAbookToRecentlyViewedShelf(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        title: snapshot.data.docs[index]
                                            ['title'],
                                        bookImage: snapshot.data.docs[index]
                                            ['medium'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                        bookId: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                      );
                                    },
                                    bookTitle: snapshot.data.docs[index]
                                        ['title'],
                                  );
                                },
                              ),
                            );
                          }

                          return Container(
                            height: 250,
                            width: MediaQuery.of(
                              context,
                            ).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      MoreBooksWidget(
                        onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel.getFullChildrensBooksStream(),
                          text: 'Children\'s Books',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Comic Books
                BookCategoriesRowWidget(
                  text: 'Comic Books',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullComicBooksStream(),
                    text: 'Comic books',
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
                        stream: viewModel.getComicBooksStream(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                        ) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: snapshot.data.docs[index]
                                        ['authors'],
                                    networkImage: snapshot.data.docs[index]
                                        ['medium'],
                                    bookId: snapshot.data.docs[index]['id'],
                                    onTap: () {
                                      viewModel.pushBookView(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        image: snapshot.data.docs[index]
                                            ['medium'],
                                        id: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                        bookTitle: snapshot.data.docs[index]
                                            ['title'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                      );
                                      viewModel.addAbookToRecentlyViewedShelf(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        title: snapshot.data.docs[index]
                                            ['title'],
                                        bookImage: snapshot.data.docs[index]
                                            ['medium'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                        bookId: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                      );
                                    },
                                    bookTitle: snapshot.data.docs[index]
                                        ['title'],
                                  );
                                },
                              ),
                            );
                          }

                          return Container(
                            height: 250,
                            width: MediaQuery.of(
                              context,
                            ).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      MoreBooksWidget(
                        onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel.getFullComicBooksStream(),
                          text: 'Comic Books',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Computers & Tech Books
                BookCategoriesRowWidget(
                  text: 'Computers & Tech',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream:
                        viewModel.getFullComputersAndTechnologyBooksStream(),
                    text: 'Computers & Tech books',
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
                        stream:
                            viewModel.getComputersAndTechnologyBooksStream(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                        ) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: snapshot.data.docs[index]
                                        ['authors'],
                                    networkImage: snapshot.data.docs[index]
                                        ['medium'],
                                    bookId: snapshot.data.docs[index]['id'],
                                    onTap: () {
                                      viewModel.pushBookView(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        image: snapshot.data.docs[index]
                                            ['medium'],
                                        id: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                        bookTitle: snapshot.data.docs[index]
                                            ['title'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                      );
                                      viewModel.addAbookToRecentlyViewedShelf(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        title: snapshot.data.docs[index]
                                            ['title'],
                                        bookImage: snapshot.data.docs[index]
                                            ['medium'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                        bookId: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                      );
                                    },
                                    bookTitle: snapshot.data.docs[index]
                                        ['title'],
                                  );
                                },
                              ),
                            );
                          }

                          return Container(
                            height: 250,
                            width: MediaQuery.of(
                              context,
                            ).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      MoreBooksWidget(
                        onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel
                              .getFullComputersAndTechnologyBooksStream(),
                          text: 'Entertainment Books',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! cooking & Food Books
                BookCategoriesRowWidget(
                  text: 'Cooking & Food',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullCookingAndFoodBooksStream(),
                    text: 'Computers & Tech books',
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
                        stream: viewModel.getCookingAndFoodBooksStream(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                        ) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: snapshot.data.docs[index]
                                        ['authors'],
                                    networkImage: snapshot.data.docs[index]
                                        ['medium'],
                                    bookId: snapshot.data.docs[index]['id'],
                                    onTap: () {
                                      viewModel.pushBookView(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        image: snapshot.data.docs[index]
                                            ['medium'],
                                        id: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                        bookTitle: snapshot.data.docs[index]
                                            ['title'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                      );
                                      viewModel.addAbookToRecentlyViewedShelf(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        title: snapshot.data.docs[index]
                                            ['title'],
                                        bookImage: snapshot.data.docs[index]
                                            ['medium'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                        bookId: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                      );
                                    },
                                    bookTitle: snapshot.data.docs[index]
                                        ['title'],
                                  );
                                },
                              ),
                            );
                          }

                          return Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      MoreBooksWidget(
                        onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel.getFullCookingAndFoodBooksStream(),
                          text: 'Cooking & Food',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! cooking & Food Books
                BookCategoriesRowWidget(
                  text: 'Fiction & Literature',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullFictionAndLiteratureBooksStream(),
                    text: 'Fiction & Literature',
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
                        stream: viewModel.getFictionAndLiteratureBooksStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: snapshot.data.docs[index]
                                        ['authors'],
                                    networkImage: snapshot.data.docs[index]
                                        ['medium'],
                                    bookId: snapshot.data.docs[index]['id'],
                                    onTap: () {
                                      viewModel.pushBookView(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        image: snapshot.data.docs[index]
                                            ['medium'],
                                        id: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                        bookTitle: snapshot.data.docs[index]
                                            ['title'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                      );
                                      viewModel.addAbookToRecentlyViewedShelf(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        title: snapshot.data.docs[index]
                                            ['title'],
                                        bookImage: snapshot.data.docs[index]
                                            ['medium'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                        bookId: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                      );
                                    },
                                    bookTitle: snapshot.data.docs[index]
                                        ['title'],
                                  );
                                },
                              ),
                            );
                          }

                          return Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      MoreBooksWidget(
                        onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel
                              .getFullFictionAndLiteratureBooksStream(),
                          text: 'Fiction & Literature ',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Health, Mind & Body Books
                BookCategoriesRowWidget(
                  text: 'Health, Mind & Body',
                  onPressed: () => viewModel.pushMoreBooksView(
                      stream: viewModel.getFullHealthMindAndbodyBooksStream(),
                      text: 'Health, Mind & Body'),
                ),
                Container(
                  height: 255,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      StreamBuilder(
                        stream: viewModel.getHealthMindAndbodyBooksStream(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                        ) {
                          if (snapshot.hasError) return snapshot.error;

                          if (snapshot.hasData) {
                            return Container(
                              height: 255,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return BookAuthorAndNameWidget(
                                    context: context,
                                    bookAuthor: snapshot.data.docs[index]
                                        ['authors'],
                                    networkImage: snapshot.data.docs[index]
                                        ['medium'],
                                    bookId: snapshot.data.docs[index]['id'],
                                    onTap: () {
                                      viewModel.pushBookView(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        image: snapshot.data.docs[index]
                                            ['medium'],
                                        id: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                        bookTitle: snapshot.data.docs[index]
                                            ['title'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                      );
                                      viewModel.addAbookToRecentlyViewedShelf(
                                        authors: snapshot.data.docs[index]
                                            ['authors'],
                                        title: snapshot.data.docs[index]
                                            ['title'],
                                        bookImage: snapshot.data.docs[index]
                                            ['medium'],
                                        previewLink: snapshot.data.docs[index]
                                            ['previewLink'],
                                        bookId: snapshot.data.docs[index]['id']
                                            .replaceAll(
                                          new RegExp(
                                            r".{/ +}",
                                          ),
                                          '',
                                        ),
                                      );
                                    },
                                    bookTitle: snapshot.data.docs[index]
                                        ['title'],
                                  );
                                },
                              ),
                            );
                          }

                          return Container(
                            height: 250,
                            width: MediaQuery.of(
                              context,
                            ).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      MoreBooksWidget(
                        onTap: () => viewModel.pushMoreBooksView(
                          stream:
                              viewModel.getFullHealthMindAndbodyBooksStream(),
                          text: 'Health, Mind & Body',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! History Books
                BookCategoriesRowWidget(
                  text: 'History',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullHistoryBooksStream(),
                    text: 'History Books',
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
                          stream: viewModel.getHistoryBooksStream(),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snapshot,
                          ) {
                            if (snapshot.hasError) return snapshot.error;

                            if (snapshot.hasData) {
                              return Container(
                                height: 255,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return BookAuthorAndNameWidget(
                                      context: context,
                                      bookAuthor: snapshot.data.docs[index]
                                          ['authors'],
                                      networkImage: snapshot.data.docs[index]
                                          ['medium'],
                                      bookId: snapshot.data.docs[index]['id'],
                                      onTap: () {
                                        viewModel.pushBookView(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          image: snapshot.data.docs[index]
                                              ['medium'],
                                          id: snapshot.data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                          bookTitle: snapshot.data.docs[index]
                                              ['title'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                        );
                                        viewModel.addAbookToRecentlyViewedShelf(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          title: snapshot.data.docs[index]
                                              ['title'],
                                          bookImage: snapshot.data.docs[index]
                                              ['medium'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                          bookId: snapshot
                                              .data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                        );
                                      },
                                      bookTitle: snapshot.data.docs[index]
                                          ['title'],
                                    );
                                  },
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
                          text: 'History Books',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Home & Garden Books
                BookCategoriesRowWidget(
                  text: 'Home & Garden',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullHomeAndGardenBooksStream(),
                    text: 'Home & Garden',
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
                          stream: viewModel.getHomeAndGardenBooksStream(),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snapshot,
                          ) {
                            if (snapshot.hasError) return snapshot.error;

                            if (snapshot.hasData) {
                              return Container(
                                height: 255,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return BookAuthorAndNameWidget(
                                      context: context,
                                      bookAuthor: snapshot.data.docs[index]
                                          ['authors'],
                                      networkImage: snapshot.data.docs[index]
                                          ['medium'],
                                      bookId: snapshot.data.docs[index]['id'],
                                      onTap: () {
                                        viewModel.pushBookView(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          image: snapshot.data.docs[index]
                                              ['medium'],
                                          id: snapshot.data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                          bookTitle: snapshot.data.docs[index]
                                              ['title'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                        );
                                        viewModel.addAbookToRecentlyViewedShelf(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          title: snapshot.data.docs[index]
                                              ['title'],
                                          bookImage: snapshot.data.docs[index]
                                              ['medium'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                          bookId: snapshot
                                              .data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                        );
                                      },
                                      bookTitle: snapshot.data.docs[index]
                                          ['title'],
                                    );
                                  },
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
                          stream: viewModel.getFullHomeAndGardenBooksStream(),
                          text: 'Home & Garden',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Mystery & Thrillers Books
                BookCategoriesRowWidget(
                  text: 'Mystery & Thrillers',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullMysteryAndThrillersBooksStream(),
                    text: 'Mystery & Thrillers',
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
                          stream: viewModel.getMysteryAndThrillersBooksStream(),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snapshot,
                          ) {
                            if (snapshot.hasError) return snapshot.error;

                            if (snapshot.hasData) {
                              return Container(
                                height: 255,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return BookAuthorAndNameWidget(
                                      context: context,
                                      bookAuthor: snapshot.data.docs[index]
                                          ['authors'],
                                      networkImage: snapshot.data.docs[index]
                                          ['medium'],
                                      bookId: snapshot.data.docs[index]['id'],
                                      onTap: () {
                                        viewModel.pushBookView(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          image: snapshot.data.docs[index]
                                              ['medium'],
                                          id: snapshot.data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                          bookTitle: snapshot.data.docs[index]
                                              ['title'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                        );
                                        viewModel.addAbookToRecentlyViewedShelf(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          title: snapshot.data.docs[index]
                                              ['title'],
                                          bookImage: snapshot.data.docs[index]
                                              ['medium'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                          bookId: snapshot
                                              .data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                        );
                                      },
                                      bookTitle: snapshot.data.docs[index]
                                          ['title'],
                                    );
                                  },
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
                          stream:
                              viewModel.getFullMysteryAndThrillersBooksStream(),
                          text: 'Mystery & Thrillers',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Science Fiction & Fantasy Books
                BookCategoriesRowWidget(
                  text: 'Fiction & Fantasy',
                  onPressed: () => viewModel.pushMoreBooksView(
                      stream: viewModel
                          .getFullScienceFictionAndFantasyBooksStream(),
                      text: 'Fiction & Fantasy'),
                ),
                Container(
                  height: 255,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      StreamBuilder(
                          stream: viewModel
                              .getScienceFictionAndFantasyBooksStream(),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snapshot,
                          ) {
                            if (snapshot.hasError) return snapshot.error;

                            if (snapshot.hasData) {
                              return Container(
                                height: 255,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return BookAuthorAndNameWidget(
                                      context: context,
                                      bookAuthor: snapshot.data.docs[index]
                                          ['authors'],
                                      networkImage: snapshot.data.docs[index]
                                          ['medium'],
                                      bookId: snapshot.data.docs[index]['id'],
                                      onTap: () {
                                        viewModel.pushBookView(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          image: snapshot.data.docs[index]
                                              ['medium'],
                                          id: snapshot.data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                          bookTitle: snapshot.data.docs[index]
                                              ['title'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                        );
                                        viewModel.addAbookToRecentlyViewedShelf(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          title: snapshot.data.docs[index]
                                              ['title'],
                                          bookImage: snapshot.data.docs[index]
                                              ['medium'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                          bookId: snapshot
                                              .data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                        );
                                      },
                                      bookTitle: snapshot.data.docs[index]
                                          ['title'],
                                    );
                                  },
                                ),
                              );
                            }

                            return Container(
                                height: 250,
                                width: MediaQuery.of(
                                  context,
                                ).size.width,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ));
                          }),
                      MoreBooksWidget(
                        onTap: () => viewModel.pushMoreBooksView(
                          stream: viewModel
                              .getFullScienceFictionAndFantasyBooksStream(),
                          text: 'Fiction & Fantasy',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Sports Books
                BookCategoriesRowWidget(
                  text: 'Sports Books',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getFullSportsBooksStream(),
                    text: 'Sports Books',
                  ),
                ),
                Container(
                  height: 255,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      StreamBuilder(
                          stream: viewModel.getSportsBooksStream(),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snapshot,
                          ) {
                            if (snapshot.hasError) return snapshot.error;

                            if (snapshot.hasData) {
                              return Container(
                                height: 255,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return BookAuthorAndNameWidget(
                                      context: context,
                                      bookAuthor: snapshot.data.docs[index]
                                          ['authors'],
                                      networkImage: snapshot.data.docs[index]
                                          ['medium'],
                                      bookId: snapshot.data.docs[index]['id'],
                                      onTap: () {
                                        viewModel.pushBookView(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          image: snapshot.data.docs[index]
                                              ['medium'],
                                          id: snapshot.data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                          bookTitle: snapshot.data.docs[index]
                                              ['title'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                        );
                                        viewModel.addAbookToRecentlyViewedShelf(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          title: snapshot.data.docs[index]
                                              ['title'],
                                          bookImage: snapshot.data.docs[index]
                                              ['medium'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                          bookId: snapshot
                                              .data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                        );
                                      },
                                      bookTitle: snapshot.data.docs[index]
                                          ['title'],
                                    );
                                  },
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
                          stream: viewModel.getFullSportsBooksStream(),
                          text: 'Sports Books',
                        ),
                      ),
                    ],
                  ),
                ),

                // ! Travel Books
                BookCategoriesRowWidget(
                  text: 'Travel Books',
                  onPressed: () => viewModel.pushMoreBooksView(
                    stream: viewModel.getTravelBooksStream(),
                    text: 'Travel books',
                  ),
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
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snapshot,
                          ) {
                            if (snapshot.hasError) return snapshot.error;

                            if (snapshot.hasData) {
                              return Container(
                                height: 255,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return BookAuthorAndNameWidget(
                                      context: context,
                                      bookAuthor: snapshot.data.docs[index]
                                          ['authors'],
                                      networkImage: snapshot.data.docs[index]
                                          ['medium'],
                                      bookId: snapshot.data.docs[index]['id'],
                                      onTap: () {
                                        viewModel.pushBookView(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          image: snapshot.data.docs[index]
                                              ['medium'],
                                          id: snapshot.data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                          bookTitle: snapshot.data.docs[index]
                                              ['title'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                        );
                                        viewModel.addAbookToRecentlyViewedShelf(
                                          authors: snapshot.data.docs[index]
                                              ['authors'],
                                          title: snapshot.data.docs[index]
                                              ['title'],
                                          bookImage: snapshot.data.docs[index]
                                              ['medium'],
                                          previewLink: snapshot.data.docs[index]
                                              ['previewLink'],
                                          bookId: snapshot
                                              .data.docs[index]['id']
                                              .replaceAll(
                                            new RegExp(
                                              r".{/ +}",
                                            ),
                                            '',
                                          ),
                                        );
                                      },
                                      bookTitle: snapshot.data.docs[index]
                                          ['title'],
                                    );
                                  },
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
                          text: 'Travel Books',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SearchViewModel(),
    );
  }
}
