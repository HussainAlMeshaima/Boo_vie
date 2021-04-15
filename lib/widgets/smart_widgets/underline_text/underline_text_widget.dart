import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'underline_text_view_model.dart';

class UnderlineTextWidget extends StatelessWidget {
  final String text;

  const UnderlineTextWidget({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UnderlineTextViewModel>.reactive(
      builder:
          (BuildContext context, UnderlineTextViewModel viewModel, Widget _) {
        return Text(
          text,
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            decoration: TextDecoration.underline,
          ),
        );
      },
      viewModelBuilder: () => UnderlineTextViewModel(),
    );
  }
}
