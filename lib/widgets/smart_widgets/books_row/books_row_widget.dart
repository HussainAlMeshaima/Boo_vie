import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'books_row_view_model.dart';

class BooksRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BooksRowViewModel>.reactive(
      builder: (BuildContext context, BooksRowViewModel viewModel, Widget _) {
        return Center(
          child: Text('BooksRow View'),
        );
      },
      viewModelBuilder: () => BooksRowViewModel(),
    );
  }
}
