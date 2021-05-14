import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'comunity_members_view_model.dart';

class ComunityMembersView extends StatelessWidget {
  final String docId;

  const ComunityMembersView({Key key, @required this.docId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComunityMembersViewModel>.reactive(
      onModelReady: (ComunityMembersViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        docId: docId,
      ),
      builder:
          (BuildContext context, ComunityMembersViewModel viewModel, Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Comunity members'),
            ),
            body: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: viewModel.getFullCommunityMembers(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot> membersDocs =
                            snapshot.data.docs;
                        membersDocs.sort(
                          (a, b) {
                            int aInt =
                                a.get('joinedDate').microsecondsSinceEpoch;
                            int bInt =
                                b.get('joinedDate').microsecondsSinceEpoch;
                            return aInt.compareTo(bInt);
                          },
                        );
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: ListTile(
                                  leading: GestureDetector(
                                    onTap: () {
                                      viewModel.pushUserReviewToProfileView(
                                          userImage: membersDocs[index]
                                              ['userImage'],
                                          userEmail: membersDocs[index]
                                              ['memberEmail']);
                                    },
                                    child: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.5),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    membersDocs[index]
                                                        ['userImage'])))),
                                  ),
                                  title:
                                      Text(membersDocs[index]['displayedName']),
                                  subtitle: Text(
                                    membersDocs[index]['role'],
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  dense: true,
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                            height: 70,
                            child: Center(
                              child: CircularProgressIndicator(),
                            )),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ));
      },
      viewModelBuilder: () => ComunityMembersViewModel(),
    );
  }
}
