import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'more_books_view_model.dart';

class MoreBooksWidget extends StatelessWidget {
  final Function onTap;
  final Stream stream;

  const MoreBooksWidget({Key key, this.onTap, this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoreBooksViewModel>.reactive(
      builder: (BuildContext context, MoreBooksViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: onTap ?? () {},
          child: Container(
            width: 160,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 15,
                    right: 5,
                    child: Container(
                        width: 100,
                        height: 160,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                        width: 125,
                        height: 180,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  Container(
                    width: 125,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        Icon(Icons.more_horiz, size: 60, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => MoreBooksViewModel(),
    );
  }
}
