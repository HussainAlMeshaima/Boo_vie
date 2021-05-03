import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'splash_screen_view_model.dart';

class SplashScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor:
            Theme.of(context).brightness == Brightness.dark
                ? Color(0xff2E2E2E)
                : Colors.white));
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      onModelReady: (SplashScreenViewModel viewModel) =>
          viewModel.handleStartUpLogic(),
      builder:
          (BuildContext context, SplashScreenViewModel viewModel, Widget _) {
        return Scaffold(
          body: Center(
            child: Hero(
              tag: 'BooVi',
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/booViLogo-Red.png'))),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => SplashScreenViewModel(),
    );
  }
}
