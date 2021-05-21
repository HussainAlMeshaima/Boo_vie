import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'create_a_new_shelf_with_name_view_model.dart';

class CreateANewShelfWithNameWidget extends StatelessWidget {
  final String bookId;
  final String bookImage;
  final String bookTitle;
  final String bookpreviewLink;
  final String authours;

  const CreateANewShelfWithNameWidget(
      {Key key,
      @required this.bookId,
      @required this.bookImage,
      @required this.bookTitle,
      @required this.bookpreviewLink,
      @required this.authours})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateANewShelfWithNameViewModel>.reactive(
      onModelReady: (CreateANewShelfWithNameViewModel viewModel) =>
          viewModel.handleStartUpLogic(
              bookId: bookId,
              bookImage: bookImage,
              bookTitle: bookTitle,
              bookpreviewLink: bookpreviewLink,
              authours: authours),
      builder: (BuildContext context,
          CreateANewShelfWithNameViewModel viewModel, Widget _) {
        return CustomScrollView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  ListTile(
                    dense: true,
                    title: Text(
                      'Set a shelf name',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20.0, top: 3),
                    child: Container(
                      child: Text(
                        viewModel.displayedShelfNameController.text,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12, left: 15, top: 15),
                        child: Container(
                          height: 150,
                          width: 94,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(viewModel.bookImage))),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextfieldWidget(
                          hintText: 'Type shelf name',
                          controller: viewModel.displayedShelfNameController,
                          maxLines: 6,
                          onChanged: (String value) {
                            viewModel.getUsernameOnChange(value);
                          },
                          onSubmitted: (String newShelfName) async {
                            if (viewModel
                                .displayedShelfNameController.text.isEmpty) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Dismissed')));
                            }

                            if (viewModel
                                .displayedShelfNameController.text.isNotEmpty) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(viewModel
                                              .displayedShelfNameController
                                              .text +
                                          ' created')));

                              await viewModel.addANewShelfByName(
                                  authors: viewModel.authors,
                                  newShelfName: viewModel
                                      .displayedShelfNameController.text,
                                  bookId: viewModel.bookId,
                                  bookImage: viewModel.bookImage,
                                  previewLink: viewModel.bookpreviewLink,
                                  title: viewModel.bookTitle);
                              viewModel.displayedShelfNameController.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 8),
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor.withOpacity(.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButtonWidget(
                    text: 'Create',
                    onPressed: () async {
                      if (viewModel.displayedShelfNameController.text.isEmpty) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Dismissed')));
                      }
                      if (viewModel
                          .displayedShelfNameController.text.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 3),
                            content: Text(
                                viewModel.displayedShelfNameController.text +
                                    ' has been created')));
                        Navigator.pop(context);
                        await viewModel.addANewShelfByName(
                            authors: viewModel.authors,
                            newShelfName:
                                viewModel.displayedShelfNameController.text,
                            bookId: viewModel.bookId,
                            bookImage: viewModel.bookImage,
                            previewLink: viewModel.bookpreviewLink,
                            title: viewModel.bookTitle);
                        viewModel.displayedShelfNameController.clear();
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
            ])),
          ],
        );
      },
      viewModelBuilder: () => CreateANewShelfWithNameViewModel(),
    );
  }
}
