import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'book_review_sheet_view_model.dart';

class BookReviewSheetWidget extends StatelessWidget {
  final String bookId;
  final String bookImage;
  final String bookTitle;
  final String bookpreviewLink;
  final String authors;

  const BookReviewSheetWidget({
    Key key,
    @required this.bookId,
    @required this.bookImage,
    @required this.bookTitle,
    @required this.bookpreviewLink,
    @required this.authors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookReviewSheetViewModel>.reactive(
      onModelReady: (BookReviewSheetViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        bookId: bookId,
        bookImage: bookImage,
        bookTitle: bookTitle,
        authors: authors,
        bookpreviewLink: bookpreviewLink,
      ),
      builder:
          (BuildContext context, BookReviewSheetViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
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
                  divisions: viewModel.emojis.length,
                  min: 0,
                  max: viewModel.emojis.length.toDouble() - 1,
                  value: viewModel.newSliderValue,
                  onChanged: (double newValue) {
                    viewModel.updateSliderOriginalValue(newValue);
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Row(children: [
                  Text('${viewModel.emojis[0.toInt()]}'),
                  Spacer(),
                  Text('${viewModel.emojis[viewModel.emojis.length - 1]}')
                ]),
              ),
              TextfieldWidget(
                maxLines: 5,
                controller: viewModel.reviewController,
              ),
              ElevatedButtonWidget(
                text: 'Send',
                onPressed: () async {
                  await viewModel.submitAReview(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              Tooltip(
                message: 'Is that review a spoiler ? 🔥',
                child: SwitchListTile(
                    value: viewModel.spoiler,
                    title: Text('Is review spoiler ? 🔥'),
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) => viewModel.toggleSpoiler(value)),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => BookReviewSheetViewModel(),
    );
  }
}
