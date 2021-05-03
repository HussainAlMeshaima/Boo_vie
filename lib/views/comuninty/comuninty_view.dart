import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comuninty_view_model.dart';
          
class ComunintyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunintyViewModel>.reactive(
      builder: (BuildContext context, ComunintyViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Comuninty View'),
          ),
        );
      },
      viewModelBuilder: () => ComunintyViewModel(),
    );
  }
}
