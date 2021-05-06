import 'package:boo_vi_app/core/models/bookModels/bookIdModel.dart';
import 'package:boo_vi_app/core/models/bookModels/booksResponseModel.dart';
import 'package:boo_vi_app/widgets/smart_widgets/list_tile_re/list_tile_re_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';
import 'book_view_model.dart';

class BookView extends StatelessWidget {
  final String id;
  final String image;
  final String text;
  final String previewLink;
  final String authors;

  const BookView({
    Key key,
    @required this.id,
    @required this.image,
    @required this.text,
    @required this.previewLink,
    @required this.authors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookViewModel>.reactive(
      onModelReady: (BookViewModel viewModel) => viewModel.handleStartUpLogic(
        bookId: id,
        bookImage: image,
        bookAuthors: authors,
        bookTitle: text,
        bookpreviewLink: previewLink,
      ),
      builder: (BuildContext context, BookViewModel viewModel, Widget _) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () => viewModel.fabOnTap(context),
            tooltip: 'Add Button',
            child: Icon(
              Icons.add,
            ),
          ),
          appBar: AppBar(
            title: Tooltip(message: 'Book View', child: Text('Book')),
            actions: [
              Tooltip(
                message: 'Share',
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(previewLink, subject: text);
                  },
                ),
              ),
            ],
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 20,
              ),
              Tooltip(
                message: 'Book Image',
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Hero(
                      tag: id,
                      child: Container(
                        height: 250,
                        width: 160,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(2, 4))
                          ],
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(image)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: viewModel.getBookById(id: id),
                builder: (BuildContext context,
                    AsyncSnapshot<BookIdVolume> snapshot) {
                  if (snapshot.hasError) return snapshot.error;

                  if (snapshot.hasData) {
                    String title = snapshot.data.volumeInfo.title ??
                        'No Title For This Book';

                    String categories = snapshot.data.volumeInfo.categories !=
                            null
                        ? viewModel.getBookcategories(
                            snapshot.data.volumeInfo.categories[0].toString())
                        : 'None';

                    String author = snapshot.data.volumeInfo.authors != null
                        ? snapshot.data.volumeInfo.authors[0].toString()
                        : 'No authors';
                    String description =
                        snapshot.data.volumeInfo.description == null
                            ? 'No Description For This Book'
                            : snapshot.data.volumeInfo.description.toString();

                    String pageCount =
                        snapshot.data.volumeInfo.pageCount == null
                            ? ' - '
                            : snapshot.data.volumeInfo.pageCount.toString();
                    String averageRating =
                        snapshot.data.volumeInfo.averageRating != null
                            ? snapshot.data.volumeInfo.averageRating.toString()
                            : '-';

                    return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                        Tooltip(
                          message: title,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 25),
                            child: Text(
                              title.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (author != 'No authors')
                                      viewModel.pushBookAuthorGridView(
                                          authorName: snapshot
                                              .data.volumeInfo.authors[0]);
                                  },
                                  child: Tooltip(
                                    message: author,
                                    child: Text(
                                      author.length >= 30
                                          ? author.substring(0, 30) + '..'
                                          : author,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Row(
                            children: [
                              Tooltip(
                                message: categories + ' category',
                                child: FilterChip(
                                  tooltip: categories,
                                  label: Text(categories.length > 30
                                      ? categories.substring(0, 30) + '..'
                                      : categories),
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  onSelected: (bool value) {
                                    if (categories != 'None')
                                      return viewModel
                                          .pushBookCategoriesGridView(
                                              bookCategories: categories);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 10),
                          child: Container(
                            height: 80,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0,
                                    right: 22,
                                    left: 12.0,
                                    bottom: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Tooltip(
                                      message: 'This book has ' +
                                          averageRating +
                                          ' as average rating in Google',
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                averageRating + ' ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17),
                                              ),
                                              Icon(
                                                Icons.star_border_rounded,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Avg. Rating',
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: VerticalDivider(
                                        thickness: 1.2,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: viewModel.getBookRatingEmoji(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError)
                                          return snapshot.error;

                                        if (snapshot.hasData) {
                                          List<double> emojisList = [];
                                          for (DocumentSnapshot item
                                              in snapshot.data.docs) {
                                            emojisList.add(item.data()[
                                                'userReviewEmojiRating']);
                                          }
                                          if (emojisList.length != 0) {
                                            double avg = emojisList
                                                .reduce((a, b) => a + b);

                                            avg = (avg / emojisList.length);

                                            int totlaAvg = avg.toInt();
                                            String emoji;

                                            switch (totlaAvg) {
                                              case 0:
                                                emoji = '😡';
                                                break;

                                              case 1:
                                                emoji = '🤢';
                                                break;

                                              case 2:
                                                emoji = '😟';
                                                break;

                                              case 3:
                                                emoji = '😧';
                                                break;

                                              case 4:
                                                emoji = '😨';
                                                break;

                                              case 5:
                                                emoji = '😰';
                                                break;

                                              case 6:
                                                emoji = '😓';
                                                break;

                                              case 7:
                                                emoji = '😫';
                                                break;

                                              case 8:
                                                emoji = '😭';
                                                break;

                                              case 9:
                                                emoji = '😦';
                                                break;

                                              case 10:
                                                emoji = '😮';
                                                break;

                                              case 11:
                                                emoji = '😃';
                                                break;

                                              case 12:
                                                emoji = '😁';
                                                break;

                                              case 13:
                                                emoji = '🥰';
                                                break;

                                              case 14:
                                                emoji = '😍';
                                                break;

                                              default:
                                                emoji = '🥱';

                                                break;
                                            }

                                            return Tooltip(
                                              message:
                                                  'The avarage rating for this book is $emoji',
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      emoji,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'BooVi',
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          return Tooltip(
                                            message:
                                                'Looks like no one reviewed this book yet 🥱',
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '🥱',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'BooVi',
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Tooltip(
                                          message: 'Rating is loading',
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'BooVi',
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: VerticalDivider(
                                        thickness: 1.2,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Tooltip(
                                      message: pageCount.toString() +
                                          ' pages in this book',
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            pageCount.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            'Pages',
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => viewModel.pushBookInformationView(
                                bookId: snapshot.data.id,
                                buyLink: snapshot.data.saleInfo.buyLink,
                                webReaderLink:
                                    snapshot.data.accessInfo.webReaderLink),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      children: [
                                        Tooltip(
                                          message: 'Book Information',
                                          child: Text(
                                            'Book Information',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Spacer(),
                                        Tooltip(
                                          message: 'More book information',
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Tooltip(
                                    message: description.length >= 160
                                        ? '     ' +
                                            description
                                                .replaceAll(
                                                    RegExp(r"<[^>]*>",
                                                        multiLine: true,
                                                        caseSensitive: true),
                                                    '')
                                                .substring(0, 160) +
                                            '...'
                                        : description.replaceAll(
                                            RegExp(r"<[^>]*>",
                                                multiLine: true,
                                                caseSensitive: true),
                                            ''),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 12,
                                            right: 12,
                                            bottom: 10),
                                        child: description ==
                                                'No Description For This Book'
                                            ? Container(
                                                height: 22,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  'No Description For This Book',
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            : Container(
                                                child: Text(
                                                  description.length >= 160
                                                      ? '     ' +
                                                          description
                                                              .replaceAll(
                                                                  RegExp(
                                                                      r"<[^>]*>",
                                                                      multiLine:
                                                                          true,
                                                                      caseSensitive:
                                                                          true),
                                                                  '')
                                                              .substring(
                                                                  0, 160) +
                                                          '...'
                                                      : description.replaceAll(
                                                          RegExp(r"<[^>]*>",
                                                              multiLine: true,
                                                              caseSensitive:
                                                                  true),
                                                          ''),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 3),
                                  child: Row(
                                    children: [
                                      Tooltip(
                                        message: 'Book Reviews',
                                        child: Text(
                                          'Book Reviews',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Spacer(),
                                      Tooltip(
                                        message: viewModel.spoiler
                                            ? 'Hide all spoilers'
                                            : 'Show all Reviews',
                                        child: Text(
                                          '🔥',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                      Tooltip(
                                        message: viewModel.spoiler
                                            ? 'Spoilers swiched on (Hide spoilers)'
                                            : 'Spoilers swiched off (Show all)',
                                        child: Switch(
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            value: viewModel.spoiler,
                                            onChanged: (value) =>
                                                viewModel.toggleSpoiler(value)),
                                      )
                                    ],
                                  ),
                                ),
                                Card(
                                  //color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: StreamBuilder(
                                        stream: viewModel.getReviewsStream(id),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasError)
                                            return snapshot.error;

                                          if (snapshot.hasData) {
                                            if (snapshot.data.docs.length ==
                                                0) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2),
                                                child: Tooltip(
                                                  message:
                                                      'No Book reviews yet ! 😭',
                                                  child: Container(
                                                    height: 87,
                                                    child: Center(
                                                      child: Text(
                                                          'No Book reviews yet ! 😭'),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }

                                            List<QueryDocumentSnapshot>
                                                reviewsDocs =
                                                snapshot.data.docs;
                                            reviewsDocs.sort(
                                              (a, b) {
                                                int aInt = a
                                                    .get('reviewDateTime')
                                                    .microsecondsSinceEpoch;
                                                int bInt = b
                                                    .get('reviewDateTime')
                                                    .microsecondsSinceEpoch;
                                                return aInt.compareTo(bInt);
                                              },
                                            );

                                            return ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount: reviewsDocs.length,
                                              itemBuilder: (context, index) {
                                                bool isThatReviewASpoiler =
                                                    reviewsDocs[index]
                                                        ['spoiler'];
                                                String newReviewString;

                                                if (isThatReviewASpoiler) {
                                                  if (viewModel.spoiler) {
                                                    newReviewString =
                                                        '🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥';
                                                  } else {
                                                    newReviewString =
                                                        reviewsDocs[index][
                                                            'userReviewString'];
                                                  }
                                                } else
                                                  newReviewString =
                                                      reviewsDocs[index]
                                                          ['userReviewString'];

                                                return GestureDetector(
                                                  onTap: () {
                                                    viewModel
                                                        .pushBookUserReview(
                                                      bookId: id,
                                                      tappedUserEmail:
                                                          reviewsDocs[index]
                                                              ['userEmail'],
                                                      bookImage: image,
                                                      spoiler:
                                                          reviewsDocs[index]
                                                              ['spoiler'],
                                                      userReviewString:
                                                          reviewsDocs[index][
                                                              'userReviewString'],
                                                      userReviewEmojiRating:
                                                          reviewsDocs[index][
                                                              'userReviewEmojiRating'],
                                                    );
                                                  },
                                                  onDoubleTap: () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        duration: Duration(
                                                            seconds: 1),
                                                        content: Text(
                                                            'Like updated'),
                                                      ),
                                                    );
                                                    viewModel.addAlikeToABook(
                                                      reviewsDocs[index]
                                                          ['userEmail'],
                                                    );
                                                  },
                                                  child: ListTileReWidget(
                                                    userEmail:
                                                        reviewsDocs[index]
                                                            ['userEmail'],
                                                    userImage:
                                                        reviewsDocs[index]
                                                            ['userImage'],
                                                    likesCounter: reviewsDocs[
                                                                index]
                                                            ['reviewLikeConter']
                                                        .toDouble(),
                                                    userName: reviewsDocs[index]
                                                        ['userName'],
                                                    userReview: newReviewString,
                                                    userSentTime: reviewsDocs[
                                                                index]
                                                            ['reviewDateTime']
                                                        .toDate(),
                                                    commentsCounter: reviewsDocs[
                                                                index][
                                                            'reviewCommentsConter']
                                                        .toDouble(),
                                                    bookImage: image,
                                                    bookId: id,
                                                  ),
                                                );
                                              },
                                            );
                                          }

                                          return Container(
                                            height: 87,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                child: Row(
                                  children: [
                                    Tooltip(
                                      message: 'Similar Books',
                                      child: Text(
                                        'Similar Books',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Spacer(),
                                    Tooltip(
                                      message: 'More similar books',
                                      child: GestureDetector(
                                        onTap: () {
                                          viewModel.pushSimilerBooksGridView(
                                              title: text);
                                        },
                                        child: Icon(Icons.arrow_forward,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 12, right: 4, bottom: 10),
                                  child: Container(
                                    height: 180,
                                    child: FutureBuilder(
                                      future: viewModel.getBooksByVolumes(
                                          volumeName: text),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<BooksResponse>
                                              snapshot) {
                                        if (snapshot.hasError)
                                          return snapshot.error;

                                        if (snapshot.hasData) {
                                          List<Items> newListOfBooks =
                                              snapshot.data.items;

                                          Set<String> bookListWithIds =
                                              newListOfBooks
                                                  .map<String>(
                                                      (book) => book.id)
                                                  .toSet();

                                          print(bookListWithIds);
                                          newListOfBooks.retainWhere((book) =>
                                              bookListWithIds.remove(book.id));

                                          newListOfBooks.removeWhere((items) =>
                                              items.volumeInfo.imageLinks ==
                                              null);
                                          newListOfBooks.removeWhere(
                                              (items) => items.id == id);

                                          if (newListOfBooks == null) {
                                            return Tooltip(
                                              message:
                                                  'books aren\'t available right now! 😭\n try again later',
                                              child: Center(
                                                child: Text(
                                                  'books aren\'t available right now! 😭\n try again later',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }
                                          return Container(
                                            width: double.infinity,
                                            child: ListView.builder(
                                              itemCount:
                                                  snapshot.data.items.length,
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if (newListOfBooks[index].id ==
                                                    id) {
                                                  return Tooltip(
                                                    message:
                                                        'Book not available',
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8),
                                                      child: Container(
                                                        child: Center(
                                                          child: Text(
                                                            'Book not available',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        height: 80,
                                                        width: 110,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor
                                                              .withOpacity(.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                if (newListOfBooks[index]
                                                        .volumeInfo
                                                        .imageLinks !=
                                                    null) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 8),
                                                    child: Tooltip(
                                                      message: newListOfBooks[
                                                                  index]
                                                              .volumeInfo
                                                              .title ??
                                                          'No title for this book',
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          viewModel
                                                              .addAbookToRecentlyViewedShelf(
                                                            authors: newListOfBooks[
                                                                        index]
                                                                    .volumeInfo
                                                                    .authors[0] ??
                                                                'No Authors',
                                                            title:
                                                                newListOfBooks[
                                                                        index]
                                                                    .volumeInfo
                                                                    .title,
                                                            bookImage:
                                                                newListOfBooks[
                                                                        index]
                                                                    .volumeInfo
                                                                    .imageLinks
                                                                    .thumbnail,
                                                            previewLink:
                                                                newListOfBooks[
                                                                        index]
                                                                    .volumeInfo
                                                                    .previewLink,
                                                            bookId:
                                                                newListOfBooks[
                                                                        index]
                                                                    .id,
                                                          );

                                                          viewModel.pushBookView(
                                                              authors: newListOfBooks[
                                                                              index]
                                                                          .volumeInfo
                                                                          .authors[
                                                                      0] ??
                                                                  'No authors',
                                                              previewLink:
                                                                  newListOfBooks[
                                                                          index]
                                                                      .volumeInfo
                                                                      .previewLink,
                                                              image: newListOfBooks[
                                                                      index]
                                                                  .volumeInfo
                                                                  .imageLinks
                                                                  .thumbnail,
                                                              id: newListOfBooks[
                                                                      index]
                                                                  .id,
                                                              bookTitle:
                                                                  newListOfBooks[
                                                                          index]
                                                                      .volumeInfo
                                                                      .title);
                                                        },
                                                        child: Hero(
                                                          tag: newListOfBooks[
                                                                  index]
                                                              .id,
                                                          child: Container(
                                                            height: 80,
                                                            width: 110,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(newListOfBooks[
                                                                        index]
                                                                    .volumeInfo
                                                                    .imageLinks
                                                                    .thumbnail),
                                                              ),
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                        'Book not available',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    );
                  }

                  return Container(
                    height: 280,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => BookViewModel(),
    );
  }
}
