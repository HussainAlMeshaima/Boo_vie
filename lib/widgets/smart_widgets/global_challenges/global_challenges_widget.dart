import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'global_challenges_view_model.dart';

class GlobalChallengesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GlobalChallengesViewModel>.reactive(
      builder: (BuildContext context, GlobalChallengesViewModel viewModel,
          Widget _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2,
                crossAxisCount: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                height: 130,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPdcLwEVds1bZuARkrbQB0ATQSfOSD3FtP_A&usqp=CAU'))),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hibernation..',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Hibernation..',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: .4,
                      ),
                    )
                  ],
                ),
              ));
            },
          ),
        );
      },
      viewModelBuilder: () => GlobalChallengesViewModel(),
    );
  }
}
