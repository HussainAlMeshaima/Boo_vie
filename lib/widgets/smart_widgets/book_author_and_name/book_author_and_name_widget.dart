import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'book_author_and_name_view_model.dart';

class BookAuthorAndNameWidget extends StatelessWidget {
  final BuildContext context;
  final String networkImage;
  final String bookTitle;
  final String bookAuthor;
  final String bookId;

  final Function onTap;

  const BookAuthorAndNameWidget(
      {Key key,
      @required this.context,
      @required this.networkImage,
      @required this.bookTitle,
      @required this.bookAuthor,
      @required this.onTap,
      @required this.bookId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookAuthorAndNameViewModel>.reactive(
      builder: (BuildContext context, BookAuthorAndNameViewModel viewModel,
          Widget _) {
        return GestureDetector(
          onTap: onTap ?? () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Hero(
                  tag: bookId,
                  child: Container(
                    width: 125,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(networkImage)),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 15,
                    left: 2,
                    child: Text(
                      bookTitle.length < 16
                          ? bookTitle
                          : bookTitle.substring(0, 16) + '..' ?? 'No Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Positioned(
                    bottom: 0,
                    left: 2,
                    child: Text(
                      bookAuthor.length < 16
                          ? bookAuthor
                          : bookAuthor.substring(0, 16) + '..' ?? 'No Author',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 12),
                    )),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => BookAuthorAndNameViewModel(),
    );
  }
}
