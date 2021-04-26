import 'package:flutter/material.dart';

class DescriptionTileWidget extends StatelessWidget {
  final String descriptionText;

  const DescriptionTileWidget({Key key, @required this.descriptionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              //side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tooltip(
                      message: 'Book Description',
                      child: Text('Description',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        child: Text(
                          descriptionText ?? 'No description for this book',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
