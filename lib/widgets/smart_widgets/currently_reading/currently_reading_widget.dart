import 'package:boo_vi_app/widgets/smart_widgets/currently_reading_bottom_sheet/currently_reading_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'currently_reading_view_model.dart';

class CurrentlyReadingWidget extends StatelessWidget {
  final String bookId;
  final String bookPreviewLink;

  final Function outlinedButtonWidgetOnPressed;
  final Function elevatedButtonWidgetOnPressed;

  final String bookImage;
  final String bookTitle;
  final String bookAuthors;
  final int bookTotalPages;
  final int bookCurrentlyReachedPages;
  final int numberOfTimesBookRead;

  const CurrentlyReadingWidget({
    Key key,
    @required this.bookImage,
    @required this.bookTitle,
    @required this.bookAuthors,
    @required this.bookTotalPages,
    @required this.bookCurrentlyReachedPages,
    @required this.bookId,
    @required this.bookPreviewLink,
    @required this.numberOfTimesBookRead,
    @required this.outlinedButtonWidgetOnPressed,
    @required this.elevatedButtonWidgetOnPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CurrentlyReadingViewModel>.reactive(
      onModelReady: (CurrentlyReadingViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        bookId: bookId,
        bookPreviewLink: bookPreviewLink,
        bookImage: bookImage,
        bookAuthors: bookAuthors,
        bookTitle: bookTitle,
        bookTotalPages: bookTotalPages,
        bookCurrentlyReachedPages: bookCurrentlyReachedPages,
        numberOfTimesBookRead: numberOfTimesBookRead,
      ),
      builder: (BuildContext context, CurrentlyReadingViewModel viewModel,
          Widget _) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return CurrentlyReadingBottomSheetWidget(
                    numberOfTimesBookRead: numberOfTimesBookRead,
                    bookId: viewModel.bookId,
                    bookPreviewLink: viewModel.bookPreviewLink,
                    bookImage: viewModel.bookImage,
                    bookAuthors: viewModel.bookAuthors,
                    bookTitle: viewModel.bookTitle,
                    bookTotalPages: viewModel.bookTotalPages,
                    bookCurrentlyReachedPages:
                        viewModel.bookCurrentlyReachedPages,
                  );
                });
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: 240,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Tooltip(
                      message: bookTitle + ' book cover',
                      child: GestureDetector(
                        onTap: () {
                          viewModel.pushBookView();
                        },
                        child: Container(
                          height: 100,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.5),
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(bookImage))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Container(
                            width: 140,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Tooltip(
                                  message: viewModel.numberOfTimesBookRead == 0
                                      ? 'Seems like it\'s your first time reading this book, 0 times read'
                                      : viewModel.numberOfTimesBookRead == 1
                                          ? 'Book has been read only once'
                                          : viewModel.numberOfTimesBookRead
                                                  .toString() +
                                              ' times book has been read',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(
                                        viewModel.numberOfTimesBookRead
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryIconTheme
                                                .color),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Tooltip(
                            message: bookTitle,
                            child: Container(
                              width: 145,
                              child: Text(
                                bookTitle,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Tooltip(
                            message: bookAuthors,
                            child: Container(
                              width: 145,
                              child: Text(
                                bookAuthors,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 11,
                                    fontStyle: FontStyle.italic),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Tooltip(
                            message:
                                '${bookCurrentlyReachedPages.toString()} / ${bookTotalPages.toString()} pages left',
                            child: Container(
                              width: 145,
                              child: Text(
                                '${bookCurrentlyReachedPages.toString()} / ${bookTotalPages.toString()} pages',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Tooltip(
                            message:
                                '${bookCurrentlyReachedPages.toString()} / ${bookTotalPages.toString()} progress',
                            child: Container(
                              width: 145,
                              child: Row(
                                children: [
                                  Container(
                                    width: 105,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: LinearProgressIndicator(
                                        value: bookCurrentlyReachedPages /
                                            bookTotalPages,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(((bookCurrentlyReachedPages /
                                                  bookTotalPages) *
                                              100)
                                          .toInt()
                                          .toString() +
                                      ' %')
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => CurrentlyReadingViewModel(),
    );
  }
}
