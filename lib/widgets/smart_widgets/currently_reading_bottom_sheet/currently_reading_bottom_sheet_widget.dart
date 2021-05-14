import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stacked/stacked.dart';
import 'currently_reading_bottom_sheet_view_model.dart';

class CurrentlyReadingBottomSheetWidget extends StatelessWidget {
  final String bookId;
  final String bookPreviewLink;

  final String outlinedButtonText;

  final String bookImage;
  final String bookTitle;
  final String bookAuthors;
  final int bookTotalPages;
  final int bookCurrentlyReachedPages;
  final int numberOfTimesBookRead;

  const CurrentlyReadingBottomSheetWidget({
    Key key,
    @required this.bookImage,
    @required this.bookTitle,
    @required this.bookAuthors,
    @required this.bookTotalPages,
    @required this.bookCurrentlyReachedPages,
    @required this.bookId,
    @required this.bookPreviewLink,
    @required this.numberOfTimesBookRead,
    this.outlinedButtonText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CurrentlyReadingBottomSheetViewModel>.reactive(
      onModelReady: (CurrentlyReadingBottomSheetViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        bookId: bookId,
        bookPreviewLink: bookPreviewLink,
        bookImage: bookImage,
        bookAuthors: bookAuthors,
        bookTitle: bookTitle,
        bookTotalPages: bookTotalPages,
        bookCurrentlyReachedPages: bookCurrentlyReachedPages,
        numberOfTimesBookRead: numberOfTimesBookRead,
        outlinedButtonText: outlinedButtonText,
      ),
      builder: (BuildContext context,
          CurrentlyReadingBottomSheetViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              ListTile(
                dense: true,
                title: Text(
                  'Update progress',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: Tooltip(
                  message: 'Number of times book read is ' +
                      viewModel.numberOfTimesBookRead.toString(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        viewModel.numberOfTimesBookRead.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).primaryIconTheme.color),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 210,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Tooltip(
                        message: viewModel.bookTitle + ' book cover',
                        child: Container(
                          height: 210,
                          width: 130,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.5),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(viewModel.bookImage)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Tooltip(
                            message: viewModel.bookTitle,
                            child: Container(
                              width: 195,
                              child: Text(
                                viewModel.bookTitle,
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Tooltip(
                            message: viewModel.bookAuthors,
                            child: Container(
                              width: 195,
                              child: Text(
                                viewModel.bookAuthors,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(context).primaryColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Tooltip(
                            message:
                                '${bookCurrentlyReachedPages.toString()} / ${bookTotalPages.toString()} progress',
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Row(
                                children: [
                                  Container(
                                    width: 140,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: LinearProgressIndicator(
                                        value: viewModel
                                                .bookCurrentlyReachedPages /
                                            viewModel.bookTotalPages,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    ((viewModel.bookCurrentlyReachedPages /
                                                    viewModel.bookTotalPages) *
                                                100)
                                            .toInt()
                                            .toString() +
                                        ' %',
                                  )
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          viewModel.switchValue
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      height: 130,
                                      width: 70,
                                      child: NumberPicker(
                                        value:
                                            viewModel.bookCurrentlyReachedPages,
                                        minValue: 0,
                                        maxValue: viewModel.bookTotalPages,
                                        onChanged: (int aNumber) {
                                          viewModel.numberPickerOnChanged(
                                              aNumber: aNumber);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Container(
                                        width: 65,
                                        child: Text(
                                          '/ ${viewModel.bookTotalPages.toString()}',
                                          style: TextStyle(fontSize: 25),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: Text(
                                        'pages',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                            width: 50,
                                            child: TextField(
                                              maxLength: 2,
                                              cursorColor:
                                                  Theme.of(context).accentColor,
                                              obscureText: false,
                                              maxLines: 1,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              onChanged:
                                                  (String onChangedString) {},
                                              decoration: InputDecoration(
                                                counterText: '',
                                                filled: true,
                                                fillColor: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Color(0xffE7E7E7)
                                                    : Color(0xff656565)
                                                        .withOpacity(0.4),
                                                hintText: ((viewModel
                                                                .bookCurrentlyReachedPages /
                                                            viewModel
                                                                .bookTotalPages) *
                                                        100)
                                                    .toInt()
                                                    .toString(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      style: BorderStyle.solid,
                                                      width: 0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      style: BorderStyle.solid,
                                                      width: 0),
                                                ),
                                                focusColor: Color(0xffE7E7E7),
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            ' % ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            '/ 100',
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          Spacer(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // SwitchListTile(
              //     dense: true,
              //     title: Row(
              //       children: [
              //         Text('Type '),
              //         SizedBox(
              //           width: 8,
              //         ),
              //         !viewModel.switchValue
              //             ? Text(
              //                 '%',
              //                 style: TextStyle(
              //                   fontSize: 21,
              //                   color: Theme.of(context).primaryColor,
              //                 ),
              //               )
              //             : Icon(
              //                 Icons.auto_stories,
              //                 size: 18,
              //                 color: Theme.of(context).primaryColor,
              //               ),
              //       ],
              //     ),
              //     value: viewModel.switchValue,
              //     activeColor: Theme.of(context).primaryColor,
              //     onChanged: (bool newValue) {
              //       viewModel.toggleSwich(newValue: newValue);
              //     }),
              SizedBox(
                height: 20,
              ),
              OutlinedButtonWidget(
                text: outlinedButtonText ?? 'Update',
                onPressed: viewModel.outlinedButtonWidgetOnPressed,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButtonWidget(
                text: 'Compleated',
                onPressed: viewModel.elevatedButtonWidgetOnPressed,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => CurrentlyReadingBottomSheetViewModel(),
    );
  }
}
