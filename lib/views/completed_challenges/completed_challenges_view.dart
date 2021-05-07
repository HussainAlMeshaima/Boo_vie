import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'completed_challenges_view_model.dart';

class CompletedChallengesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompletedChallengesViewModel>.reactive(
      builder: (BuildContext context, CompletedChallengesViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Completed'),
          ),
          body: StreamBuilder(
            stream: viewModel.getCompletedChallengesStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.isEmpty) {
                  return Center(
                    child: Text('No completed challenges yet 😭'),
                  );
                }
                if (snapshot.data.docs.isNotEmpty) {
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
      viewModelBuilder: () => CompletedChallengesViewModel(),
    );
  }
}
