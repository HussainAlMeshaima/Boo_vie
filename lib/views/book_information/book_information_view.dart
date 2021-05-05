import 'package:boo_vi_app/core/models/bookModels/bookIdModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                floating: true,
                title: Text('Book Information'),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                FutureBuilder(
                  future: viewModel.getBookById(id: bookId),
                  builder: (BuildContext context,
                      AsyncSnapshot<BookIdVolume> snapshot) {
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
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          DescriptionTileWidget(
                            descriptionText:
                                snapshot.data.volumeInfo.description != null
                                    ? snapshot.data.volumeInfo.description
                                        .replaceAll(
                                            RegExp(r"<[^>]*>",
                                                multiLine: true,
                                                caseSensitive: true),
                                            '')
                                    : 'No Description For This Book',
                          ),
                          InformationTileWidget(
                            leadingText: 'Title',
                            trailingText: snapshot.data.volumeInfo.title,
                          ),
                          InformationTileWidget(
                            leadingText: 'Authors',
                            trailingText: viewModel
                                .getAuthors(snapshot.data.volumeInfo.authors),
                          ),
                          InformationTileWidget(
                            leadingText: 'Pages',
                            trailingText:
                                snapshot.data.volumeInfo.pageCount.toString(),
                          ),
                          InformationTileWidget(
                            leadingText: 'Date',
                            trailingText: snapshot.data.volumeInfo.publishedDate
                                .toString(),
                          ),
                          InformationTileWidget(
                            leadingText: 'Publisher',
                            trailingText: snapshot.data.volumeInfo.publisher,
                          ),
                          InformationTileWidget(
                              leadingText: 'Categories',
                              fontSize: 14,
                              trailingText: viewModel.getCategories(
                                  snapshot.data.volumeInfo.categories)),
                          InformationTileWidget(
                            leadingText: 'Type',
                            trailingText: snapshot.data.volumeInfo.printType
                                .toLowerCase()
                                .toString(),
                          ),
                          if (snapshot.data.volumeInfo.industryIdentifiers !=
                              null)
                            if (snapshot.data.volumeInfo.industryIdentifiers
                                    .length >=
                                1)
                              for (var item in snapshot
                                  .data.volumeInfo.industryIdentifiers)
                                InformationTileWidget(
                                  leadingText: item.type.replaceAll('_', ' '),
                                  trailingText: item.identifier.toString(),
                                ),
                          InformationTileWidget(
                            leadingText: 'ID',
                            trailingText: snapshot.data.id,
                          ),
                          InformationTileWidget(
                            leadingText: 'E-tag',
                            trailingText: snapshot.data.etag,
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
              ]))
            ],
          ),
          floatingActionButton: SpeedDial(
            icon: Icons.link,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).primaryIconTheme.color,
            useRotationAnimation: false,
            //child: Icon(Icons.book),
            children: [
              if (buyLink != null)
                SpeedDialChild(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).primaryIconTheme.color,
                    labelBackgroundColor: Theme.of(context).cardColor,
                    label: 'Buy',
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                    onTap: () async {
                      await launch(buyLink);
                    }),
              if (webReaderLink != null)
                SpeedDialChild(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).primaryIconTheme.color,
                    labelBackgroundColor: Theme.of(context).cardColor,
                    label: 'Read',
                    child: Icon(
                      Icons.auto_stories,
                    ),
                    onTap: () async {
                      await launch(webReaderLink);
                    }),
              if (webReaderLink != null)
                SpeedDialChild(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).primaryIconTheme.color,
                  labelBackgroundColor: Theme.of(context).cardColor,
                  label: 'QR code',
                  child: Icon(
                    Icons.qr_code_rounded,
                  ),
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 2.8,
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                await launch(webReaderLink);
                              },
                              child: QrImage(
                                data: webReaderLink,
                                version: QrVersions.auto,
                                size: 180.0,
                                foregroundColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        );
      },
      viewModelBuilder: () => BookInformationViewModel(),
    );
  }
}
