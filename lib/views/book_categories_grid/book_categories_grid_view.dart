import 'package:boo_vi_app/core/models/bookModels/booksResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'book_categories_grid_view_model.dart';

class BookCategoriesGridView extends StatelessWidget {
  final String categories;

  const BookCategoriesGridView({Key key, @required this.categories})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookCategoriesGridViewModel>.reactive(
      onModelReady: (BookCategoriesGridViewModel viewModel) =>
          viewModel.handleStartUpLogic(categories),
      builder: (BuildContext context, BookCategoriesGridViewModel viewModel,
          Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Book Categories'),
            ),
            body: FutureBuilder<BooksResponse>(
                future: viewModel.getBooksBycategories(categories),
                builder: (BuildContext context,
                    AsyncSnapshot<BooksResponse> snapshot) {
                  if (snapshot.hasError) return snapshot.error;

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
                                    null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        viewModel.addAbookToRecentlyViewedShelf(
                                          authors: newListOfBooks[index]
                                                  .volumeInfo
                                                  .authors[0] ??
                                              'No Authors',
                                          title: newListOfBooks[index]
                                              .volumeInfo
                                              .title,
                                          bookImage: newListOfBooks[index]
                                              .volumeInfo
                                              .imageLinks
                                              .thumbnail,
                                          previewLink: newListOfBooks[index]
                                              .volumeInfo
                                              .previewLink,
                                          bookId: newListOfBooks[index].id,
                                        );
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
      viewModelBuilder: () => BookCategoriesGridViewModel(),
    );
  }
}
