import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'my_challanges_view_model.dart';

class MyChallangesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyChallangesViewModel>.reactive(
      builder:
          (BuildContext context, MyChallangesViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('My Challange'),
          ),
          body: Center(
            child: Text('MyChallanges View'),
          ),
        );
      },
      viewModelBuilder: () => MyChallangesViewModel(),
    );
  }
}
