import 'dart:ui';

import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';
import 'my_challanges_view_model.dart';

class MyChallangesView extends StatelessWidget {
  final String title;
  final String id;
  final String authors;
  final String bookImage;
  final bool isCompleated;
  final String previewLink;
  final Timestamp setToDate;

  const MyChallangesView(
      {Key key,
      @required this.title,
      @required this.id,
      @required this.authors,
      @required this.bookImage,
      @required this.isCompleated,
      @required this.previewLink,
      @required this.setToDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyChallangesViewModel>.reactive(
      onModelReady: (MyChallangesViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        title: title,
        id: id,
        authors: authors,
        bookImage: bookImage,
        isCompleated: isCompleated,
        previewLink: previewLink,
        setToDate: setToDate,
      ),
      builder:
          (BuildContext context, MyChallangesViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('My Challange'),
            actions: [
              Tooltip(
                message: 'Share',
                child: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      Share.share(viewModel.previewLink,
                          subject: viewModel.previewLink);
                    }),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () => viewModel.pushBookView(),
                  child: Tooltip(
                    message: 'Book image',
                    child: Center(
                      child: Hero(
                        tag: viewModel.id,
                        child: Container(
                          height: 320,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(viewModel.bookImage)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: viewModel.getUserMyChallangeSetToDateStream(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      if (viewModel.challangeHasNotBeenCompleated) {
                        return Container(
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Tooltip(
                              message: 'Challenge Compleated 😊',
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: new ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.dstATop),
                                        image:
                                            NetworkImage(viewModel.bookImage),
                                      ),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10,
                                          sigmaY: 10,
                                          tileMode: TileMode.clamp),
                                      child: Container(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.green.withOpacity(0.5)
                                            : Colors.green.withOpacity(0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Center(
                                            child: Text(
                                              'Challenge Compleated 😊',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (viewModel.challangeTimeIsNotDone) {
                        return Container(
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter: new ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.dstATop),
                                      image: NetworkImage(
                                        viewModel.bookImage,
                                      ),
                                    ),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10,
                                        sigmaY: 10,
                                        tileMode: TileMode.clamp),
                                    child: Container(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.red.withOpacity(0.5)
                                          : Colors.red.withOpacity(0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Center(
                                          child: Text(
                                            'Challenge dismissed 😭',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      return Container(
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.dstATop),
                                    image: NetworkImage(
                                      viewModel.bookImage,
                                    ),
                                  ),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                      tileMode: TileMode.clamp),
                                  child: Container(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.black.withOpacity(0.5)
                                        : Colors.white.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                viewModel.numberOfdays
                                                    .toString(),
                                                style: TextStyle(fontSize: 26),
                                              ),
                                              Text(
                                                'DAYS',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .color
                                                        .withOpacity(.35)),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .color
                                                    .withOpacity(.7)),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                viewModel.numberOfhours
                                                    .toString(),
                                                style: TextStyle(fontSize: 26),
                                              ),
                                              Text(
                                                'HOUR',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .color
                                                        .withOpacity(.35)),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .color
                                                    .withOpacity(.7)),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                viewModel.numberOfminutes
                                                    .toString(),
                                                style: TextStyle(fontSize: 26),
                                              ),
                                              Text(
                                                'MIN',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .color
                                                        .withOpacity(.35)),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .color
                                                    .withOpacity(.7)),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                viewModel.numberOfseconds
                                                    .toString(),
                                                style: TextStyle(fontSize: 26),
                                              ),
                                              Text(
                                                'SEC',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .color
                                                        .withOpacity(.35)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Container(
                      height: 120,
                      child: Container(
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            15.0,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(
                                        0.5,
                                      ),
                                      BlendMode.dstATop,
                                    ),
                                    image: NetworkImage(
                                      viewModel.bookImage,
                                    ),
                                  ),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                    tileMode: TileMode.clamp,
                                  ),
                                  child: Container(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.black.withOpacity(
                                            0.5,
                                          )
                                        : Colors.white.withOpacity(
                                            0.5,
                                          ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                viewModel.showMarkAsDoneButton
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButtonWidget(
                          text: 'Mark as done',
                          onPressed: () async {
                            await viewModel.markMyChallangeAsCompleated(
                                context: context);
                          },
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButtonWidget(
                          text: 'Mark as done',
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButtonWidget(
                    text: 'Remove',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text(
                              'Long press the button to remove challange.'),
                        ),
                      );
                    },
                    onLongPress: () async {
                      await viewModel.removeChallangeFromMyChallange(
                          context: context);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => MyChallangesViewModel(),
    );
  }
}
