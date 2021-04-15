import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ComunintysViewModel extends BaseViewModel {
  Logger log;

  ComunintysViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  handleSwipIndexChanged(int swipdIndex) {
    if (swipdIndex != _pageIndex) _pageIndex = swipdIndex;
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 450), curve: Curves.easeOutSine);

    notifyListeners();
  }

  handleTapIndexChanged(int tapedIndex) {
    if (tapedIndex != _pageIndex) _pageIndex = tapedIndex;
    pageController.jumpToPage(pageIndex);

    notifyListeners();
  }
}
