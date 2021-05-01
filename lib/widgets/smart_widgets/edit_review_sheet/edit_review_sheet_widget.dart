import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'edit_review_sheet_view_model.dart';

class EditReviewSheetWidget extends StatelessWidget {
  final String bookId;
  final bool spoiler;
  final bool editSpoiler;
  final String userReviewString;
  final double userReviewEmojiRating;

  const EditReviewSheetWidget({
    Key key,
    @required this.bookId,
    @required this.spoiler,
    @required this.editSpoiler,
    @required this.userReviewString,
    @required this.userReviewEmojiRating,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditReviewSheetViewModel>.reactive(
      onModelReady: (EditReviewSheetViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        bookId: bookId,
        spoiler: spoiler,
        editSpoiler: editSpoiler,
        userReviewString: userReviewString,
        userReviewEmojiRating: userReviewEmojiRating,
      ),
      builder:
          (BuildContext context, EditReviewSheetViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
              child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Center(
                child: Container(
                  height: 40,
                  child: Text(
                    '${viewModel.emojis[viewModel.userReviewEmojiRating.toInt()]}',
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
                  value: viewModel.userReviewEmojiRating,
                  onChanged: (double newValue) =>
                      viewModel.updateSliderOriginalValue(newValue)),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Row(children: [
                  Text('${viewModel.emojis[0]}'),
                  Spacer(),
                  Text('${viewModel.emojis[viewModel.emojis.length - 1]}')
                ]),
              ),
              TextfieldWidget(
                maxLines: 5,
                controller: viewModel.reviewController,
                onSubmitted: (a) async {},
              ),
              ElevatedButtonWidget(
                text: 'Update',
                onPressed: () async {
                  Navigator.pop(context);
                  await viewModel.updateThatUserReviewForThatBook();
                },
              ),
              SizedBox(
                height: 5,
              ),
              Tooltip(
                message: 'Is that review a spoiler ? 🔥',
                child: SwitchListTile(
                    value: viewModel.editSpoiler,
                    title: Text('Is review spoiler ? 🔥'),
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      viewModel.toggleSpoiler(value);
                    }),
              )
            ],
          )),
        );
      },
      viewModelBuilder: () => EditReviewSheetViewModel(),
    );
  }
}
