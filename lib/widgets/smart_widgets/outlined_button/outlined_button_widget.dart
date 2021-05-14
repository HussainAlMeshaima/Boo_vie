import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'outlined_button_view_model.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Function onLongPress;
  final String message;

  const OutlinedButtonWidget(
      {Key key, this.text, this.onPressed, this.onLongPress, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OutlinedButtonViewModel>.reactive(
      builder:
          (BuildContext context, OutlinedButtonViewModel viewModel, Widget _) {
        return Tooltip(
          message: message ?? text,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: OutlinedButton(
              onLongPress: onLongPress,
              style: OutlinedButton.styleFrom(
                primary: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                side:
                    BorderSide(color: Theme.of(context).primaryColor, width: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18, fontFamily: 'DM Mono'),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => OutlinedButtonViewModel(),
    );
  }
}
