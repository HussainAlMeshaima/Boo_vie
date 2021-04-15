import 'package:boo_vi_app/core/models/bookModels/booksResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'book_author_grid_view_model.dart';

class BookAuthorGridView extends StatelessWidget {
  final String authorName;

  const BookAuthorGridView({Key key, @required this.authorName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookAuthorGridViewModel>.reactive(
      builder:
          (BuildContext context, BookAuthorGridViewModel viewModel, Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Books By Author'),
            ),
            body: FutureBuilder<BooksResponse>(
                future: viewModel.getBooksByAuthor(authorName),
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
                    return Container(
                      child: GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1 / 1.6, crossAxisCount: 3),
                          itemCount: snapshot.data.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            BooksResponse books;

                            books = snapshot.data;
                            print(books.totalItems);
                            return snapshot.data.items[index].volumeInfo
                                            .imageLinks !=
                                        null &&
                                    snapshot.data.items[index].volumeInfo
                                            .imageLinks.thumbnail !=
                                        null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () => viewModel.pushBookView(
                                          id: snapshot.data.items[index].id,
                                          image: snapshot.data.items[index]
                                              .volumeInfo.imageLinks.thumbnail,
                                          previewLink: snapshot
                                              .data
                                              .items[index]
                                              .volumeInfo
                                              .previewLink,
                                          bookTitle: snapshot.data.items[index]
                                              .volumeInfo.title),
                                      child: Hero(
                                        tag: snapshot.data.items[index].id,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(snapshot
                                                  .data
                                                  .items[index]
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
      viewModelBuilder: () => BookAuthorGridViewModel(),
    );
  }
}
