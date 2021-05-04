import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'introduction_screen_view_model.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IntroductionScreenViewModel>.reactive(
      builder: (BuildContext context, IntroductionScreenViewModel viewModel,
          Widget _) {
        return Scaffold(
            body: IntroductionScreen(
          showDoneButton: true,
          showNextButton: true,
          skip: Text(
            'Skip',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          next: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).primaryColor,
          ),
          done: Text('Done',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor)),
          color: Theme.of(context).primaryColor,
          doneColor: Theme.of(context).primaryColor,
          nextColor: Theme.of(context).primaryColor,
          skipColor: Theme.of(context).primaryColor,
          curve: Curves.easeIn,
          showSkipButton: true,
          dotsDecorator: DotsDecorator(
            activeColor: Theme.of(context).primaryColor,
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          onDone: () => viewModel.pushStartUpView(),
          pages: [
            PageViewModel(
              titleWidget: Text(
                'Welcome To BooVi',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              image: Image.asset(
                'assets/introAssets/welcomeToBooV.png',
                scale: 4,
              ),
              // title: "Welcome To BooVi",
              body:
                  "A warm welcome and lots of good wishes on becoming part of our growing team. Welcome and on behalf of all the team members.",
            ),
            PageViewModel(
              titleWidget: Text(
                'Why review books ?',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              image: Image.asset(
                'assets/introAssets/aboutBooVi.png',
                scale: 1,
              ),
              // title: "Welcome To BooVi",
              body:
                  "Simple. Reviews is a guide for potential readers. BooVi give books greater visibility and a greater chance of getting found by more and more readers.",
            ),
            PageViewModel(
              titleWidget: Text(
                'Why review books ?',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              image: Image.asset(
                'assets/introAssets/shareReviews.png',
                scale: 1,
              ),
              // title: "Welcome To BooVi",
              body:
                  "Simple. Reviews is a guide for potential readers. BooVi give books greater visibility and a greater chance of getting found by more and more readers.",
            ),
            PageViewModel(
              titleWidget: Text(
                'Why review books ?',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              image: Image.asset(
                'assets/introAssets/reading.png',
                scale: 11,
              ),
              // title: "Welcome To BooVi",
              body:
                  "Simple. Reviews is a guide for potential readers. BooVi give books greater visibility and a greater chance of getting found by more and more readers.",
            ),
          ],
        ));
      },
      viewModelBuilder: () => IntroductionScreenViewModel(),
    );
  }
}
