import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'book_review_sheet_view_model.dart';

class BookReviewSheetWidget extends StatelessWidget {
  final String bookId;
  final String bookImage;
  final String bookTitle;
  final String bookpreviewLink;

  const BookReviewSheetWidget(
      {Key key,
      this.bookId,
      this.bookImage,
      this.bookTitle,
      this.bookpreviewLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookReviewSheetViewModel>.reactive(
      onModelReady: (BookReviewSheetViewModel viewModel) =>
          viewModel.handleStartUpLogic(
              bookId: bookId,
              bookImage: bookImage,
              bookTitle: bookTitle,
              bookpreviewLink: bookpreviewLink),
      builder:
          (BuildContext context, BookReviewSheetViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Review',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Container(
                    height: 40,
                    child: Text(
                      '${viewModel.emojis[viewModel.newSliderValue.toInt()]}',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Slider(
                    inactiveColor: Theme.of(context).cardColor,
                    activeColor: Theme.of(context).primaryColor,
                    divisions: 10,
                    min: 0,
                    max: 10,
                    // label: viewModel.emojis[viewModel.newSliderValue.toInt()]
                    //     .toString(),
                    value: viewModel.newSliderValue,
                    onChanged: (double newValue) {
                      viewModel.updateSliderOriginalValue(newValue);
                    }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Row(children: [
                    Text('${viewModel.emojis[0.toInt()]}'),
                    Spacer(),
                    Text('${viewModel.emojis[10.toInt()]}')
                  ]),
                ),
                TextfieldWidget(
                  maxLines: 5,
                  controller: viewModel.reviewController,
                  onSubmitted: (a) => viewModel.submitAReview(context),
                ),
                // ElevatedButtonWidget(
                //   text: 'Submit',
                //   onPressed: () => viewModel.submitAReview(context),
                // ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => BookReviewSheetViewModel(),
    );
  }
}

class SubmitAReview {}
