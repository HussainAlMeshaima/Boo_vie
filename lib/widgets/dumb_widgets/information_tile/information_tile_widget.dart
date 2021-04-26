import 'package:flutter/material.dart';

class InformationTileWidget extends StatelessWidget {
  final String leadingText;
  final String trailingText;
  final double fontSize;

  const InformationTileWidget(
      {Key key, this.leadingText, this.trailingText, this.fontSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              //side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 15),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tooltip(
                          message: 'Book ' + leadingText,
                          child: Text(leadingText ?? 'None',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          width: 165,
                          child: Tooltip(
                            message: 'The Book ' +
                                leadingText +
                                ' is: ' +
                                trailingText,
                            child: Text(
                              trailingText ?? 'None',
                              style: TextStyle(fontSize: fontSize ?? 16),
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
