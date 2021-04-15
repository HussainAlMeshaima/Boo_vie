import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  final IconData leadingIconData;

  final Function onTap;

  const ListTileWidget(
      {Key key,
      this.text,
      this.fontSize,
      this.fontWeight,
      this.leadingIconData,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
      leading: Icon(leadingIconData),
      onTap: onTap,
    );
  }
}
