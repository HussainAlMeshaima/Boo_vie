import 'package:boo_vi_app/core/models/bookModels/booksResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'similer_books_grid_view_model.dart';

class SimilerBooksGridView extends StatelessWidget {
  final String title;

  const SimilerBooksGridView({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SimilerBooksGridViewModel>.reactive(
      builder: (BuildContext context, SimilerBooksGridViewModel viewModel,
          Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Similer Books'),
            ),
            body: FutureBuilder<BooksResponse>(
                future: viewModel.getBooksByVolumes(title),
                builder: (BuildContext context,
                    AsyncSnapshot<BooksResponse> snapshot) {
                  if (snapshot.hasError)
                    return Container(
                      height: 400,
                      child: Center(
                        child: Text('An error has been found'),
                      ),
                    );
                  else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.data.totalItems == 0) {
                    return Container(
                      height: 450,
                      child: Center(
                        child: Text('No Books Found'),
                      ),
                    );
                  }

                  if (snapshot.hasData && snapshot.data.totalItems != 0) {
                    List<Items> newListOfBooks = snapshot.data.items;

                    Set<String> bookListWithIds =
                        newListOfBooks.map<String>((book) => book.id).toSet();

                    print(bookListWithIds);
                    newListOfBooks
                        .retainWhere((book) => bookListWithIds.remove(book.id));

                    newListOfBooks.removeWhere((book) => book.id == null);

                    newListOfBooks
                        .removeWhere((book) => book.volumeInfo.authors == null);

                    newListOfBooks.removeWhere(
                        (book) => book.volumeInfo.previewLink == null);

                    newListOfBooks.removeWhere(
                        (book) => book.volumeInfo.imageLinks == null);
                    return Container(
                      child: GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1 / 1.6, crossAxisCount: 3),
                          itemCount: snapshot.data.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return newListOfBooks[index]
                                            .volumeInfo
                                            .imageLinks !=
                                        null &&
                                    newListOfBooks[index]
                                            .volumeInfo
                                            .imageLinks
                                            .thumbnail !=
                                        null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        viewModel.addAbookToRecentlyViewedShelf(
                                            authors: newListOfBooks[index]
                                                    .volumeInfo
                                                    .authors[0] ??
                                                'No authors',
                                            bookId: newListOfBooks[index].id,
                                            bookImage: newListOfBooks[index]
                                                .volumeInfo
                                                .imageLinks
                                                .thumbnail,
                                            previewLink: newListOfBooks[index]
                                                .volumeInfo
                                                .previewLink,
                                            title: newListOfBooks[index]
                                                .volumeInfo
                                                .title);
                                        viewModel.pushBookView(
                                            authors: newListOfBooks[index]
                                                    .volumeInfo
                                                    .authors[0] ??
                                                'No authors',
                                            id: newListOfBooks[index].id,
                                            image: newListOfBooks[index]
                                                .volumeInfo
                                                .imageLinks
                                                .thumbnail,
                                            previewLink: newListOfBooks[index]
                                                .volumeInfo
                                                .previewLink,
                                            bookTitle: newListOfBooks[index]
                                                .volumeInfo
                                                .title);
                                      },
                                      child: Hero(
                                        tag: newListOfBooks[index].id,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  newListOfBooks[index]
                                                      .volumeInfo
                                                      .imageLinks
                                                      .thumbnail),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        child: Center(
                                            child: Text(
                                          'Book not available',
                                          textAlign: TextAlign.center,
                                        )),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.5),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        )),
                                  );
                          }),
                    );
                  }

                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }));
      },
      viewModelBuilder: () => SimilerBooksGridViewModel(),
    );
  }
}
