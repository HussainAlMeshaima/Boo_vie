import 'package:boo_vi_app/widgets/smart_widgets/global_challenges/global_challenges_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'challenges_view_model.dart';

class ChallengesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChallengesViewModel>.reactive(
      builder: (BuildContext context, ChallengesViewModel viewModel, Widget _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Challenges'),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Text('Global challenges')),
                  Tab(icon: Text('My challenges')),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                GlobalChallengesWidget(),
                Center(
                  child: Text('Challenges View'),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ChallengesViewModel(),
    );
  }
}
