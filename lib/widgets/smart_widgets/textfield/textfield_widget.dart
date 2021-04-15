import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'textfield_view_model.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Function onSubmitted;
  final bool enabled;
  final String labelText;
  final TextInputType textInputType;

  final IconData iconData;
  final Function onPressedIcon;

  final Function onChanged;
  final String onChangedString;

  final int maxLines;

  const TextfieldWidget(
      {Key key,
      this.controller,
      this.hintText,
      this.obscureText,
      this.onSubmitted,
      this.enabled,
      this.labelText,
      this.textInputType,
      this.iconData,
      this.onPressedIcon,
      this.onChanged,
      this.onChangedString,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TextfieldViewModel>.reactive(
      builder: (BuildContext context, TextfieldViewModel viewModel, Widget _) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: TextField(
              cursorColor: Theme.of(context).accentColor,
              controller: controller,
              obscureText: obscureText ?? false,
              onSubmitted: onSubmitted,
              enabled: enabled,
              maxLines: maxLines ?? 1,
              keyboardType: textInputType ?? TextInputType.name,
              onChanged: onChanged ?? (String onChangedString) {},
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    iconData,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: onPressedIcon ?? () {},
                ),
                labelText: labelText,
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.light
                    ? Color(0xffE7E7E7)
                    : Color(0xff656565).withOpacity(0.4),
                hintText: hintText,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.transparent,
                      style: BorderStyle.solid,
                      width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                      color: Colors.transparent,
                      style: BorderStyle.solid,
                      width: 0),
                ),
                focusColor: Color(0xffE7E7E7),
              ),
            ));
      },
      viewModelBuilder: () => TextfieldViewModel(),
    );
  }
}
