import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'elevated_button_view_model.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final Function() onLongPress;
  final String text;

  const ElevatedButtonWidget(
      {Key key, this.onPressed, this.text, this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ElevatedButtonViewModel>.reactive(
      builder:
          (BuildContext context, ElevatedButtonViewModel viewModel, Widget _) {
        return Tooltip(
          message: text,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: ElevatedButton(
              onPressed: onPressed,
              onLongPress: onLongPress,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18, fontFamily: 'DM Mono'),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ElevatedButtonViewModel(),
    );
  }
}
