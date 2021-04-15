import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'book_categories_row_view_model.dart';

class BookCategoriesRowWidget extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BookCategoriesRowWidget({Key key, @required this.text, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookCategoriesRowWidgetViewModel>.reactive(
      builder: (BuildContext context,
          BookCategoriesRowWidgetViewModel viewModel, Widget _) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(children: [
            Text(
              text,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(
                icon: Icon(Icons.arrow_forward), onPressed: onPressed ?? () {})
          ]),
        );
      },
      viewModelBuilder: () => BookCategoriesRowWidgetViewModel(),
    );
  }
}
