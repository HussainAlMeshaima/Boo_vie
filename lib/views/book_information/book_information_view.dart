import 'package:boo_vi_app/core/models/bookModels/bookIdModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'book_information_view_model.dart';

import 'package:boo_vi_app/widgets/dumb_widgets/information_tile/information_tile_widget.dart';
import 'package:boo_vi_app/widgets/dumb_widgets/description_tile/description_tile_widget.dart';

class BookInformationView extends StatelessWidget {
  final String bookId;
  final String buyLink;
  final String webReaderLink;
  final String previewLink;

  const BookInformationView(
      {Key key,
      this.bookId,
      this.buyLink,
      this.webReaderLink,
      this.previewLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookInformationViewModel>.reactive(
      builder:
          (BuildContext context, BookInformationViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Book Information'),
          ),
          body: FutureBuilder(
            future: viewModel.getBookById(id: bookId),
            builder:
                (BuildContext context, AsyncSnapshot<BookIdVolume> snapshot) {
              if (snapshot.hasError)
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text('Something went wrong please try again'),
                  ),
                );

              if (snapshot.hasData) {
                return ListView(
                  physics: ScrollPhysics(),
                  children: [
                    InformationTileWidget(
                      leadingText: 'Title',
                      trailingText: snapshot.data.volumeInfo.title,
                    ),
                    InformationTileWidget(
                      leadingText: 'Authors',
                      fontSize: 14,
                      trailingText: viewModel
                          .getAuthors(snapshot.data.volumeInfo.authors),
                    ),
                    InformationTileWidget(
                      leadingText: 'Type',
                      trailingText:
                          snapshot.data.volumeInfo.printType.toString(),
                    ),
                    InformationTileWidget(
                      leadingText: 'Pages',
                      trailingText:
                          snapshot.data.volumeInfo.pageCount.toString(),
                    ),
                    DescriptionTileWidget(
                      descriptionText: snapshot.data.volumeInfo.description
                          .replaceAll(
                              RegExp(r"<[^>]*>",
                                  multiLine: true, caseSensitive: true),
                              ''),
                    ),
                    InformationTileWidget(
                      leadingText: 'Publisher',
                      trailingText: snapshot.data.volumeInfo.publisher,
                    ),
                    InformationTileWidget(
                      leadingText: 'Date',
                      trailingText:
                          snapshot.data.volumeInfo.publishedDate.toString(),
                    ),
                    InformationTileWidget(
                      leadingText: 'Pages',
                      trailingText:
                          snapshot.data.volumeInfo.pageCount.toString(),
                    ),
                    InformationTileWidget(
                        leadingText: 'Categories',
                        fontSize: 14,
                        trailingText: viewModel.getCategories(
                            snapshot.data.volumeInfo.categories)),
                    InformationTileWidget(
                      leadingText: 'ID',
                      trailingText: snapshot.data.id,
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                );
              }

              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          floatingActionButton: SpeedDial(
            icon: Icons.link, foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            useRotationAnimation: false,
            //child: Icon(Icons.book),
            children: [
              if (buyLink != null)
                SpeedDialChild(
                    backgroundColor: Theme.of(context).primaryColor,
                    labelBackgroundColor: Theme.of(context).cardColor,
                    label: 'Buy',
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      await launch(buyLink);
                    }),
              if (webReaderLink != null)
                SpeedDialChild(
                    backgroundColor: Theme.of(context).primaryColor,
                    labelBackgroundColor: Theme.of(context).cardColor,
                    label: 'Read',
                    child: Icon(
                      Icons.auto_stories,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      await launch(webReaderLink);
                    }),
            ],
          ),
        );
      },
      viewModelBuilder: () => BookInformationViewModel(),
    );
  }
}
