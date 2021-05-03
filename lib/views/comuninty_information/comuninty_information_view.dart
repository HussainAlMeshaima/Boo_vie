import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comuninty_information_view_model.dart';

class ComunintyInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunintyInformationViewModel>.reactive(
      builder: (BuildContext context, ComunintyInformationViewModel viewModel,
          Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Comuninty information'),
            ),
            body: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                Hero(
                  tag: 1,
                  child: Container(
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/80004f68741469.5bae1b8424f4c.jpg')),
                    ),
                  ),
                ),
              ],
            ));
      },
      viewModelBuilder: () => ComunintyInformationViewModel(),
    );
  }
}
