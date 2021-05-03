import 'package:boo_vi_app/views/comunintys/comunintys_view.dart';
import 'package:boo_vi_app/views/challenges/challenges_view.dart';
import 'package:boo_vi_app/views/home/home_view.dart';
import 'package:boo_vi_app/views/profile/profile_view.dart';
import 'package:boo_vi_app/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'start_up_view_model.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      builder: (BuildContext context, StartUpViewModel viewModel, Widget _) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: viewModel.pageIndex,
            onTap: (int page) => viewModel.handleTapIndexChanged(page),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).iconTheme.color,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.timer,
                  ),
                  label: 'Challanges'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.group_work), label: 'Communitys'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile')
            ],
          ),
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: viewModel.pageController,
                onPageChanged: (int index) =>
                    viewModel.handleSwipIndexChanged(index),
                children: [
                  HomeView(),
                  ChallengesView(),
                  SearchView(),
                  ComunintysView(),
                  ProfileView(),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
