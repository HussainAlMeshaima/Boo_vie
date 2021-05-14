import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'edit_community_rules_and_discription_view_model.dart';

class EditCommunityRulesAndDiscriptionView extends StatelessWidget {
  final String docId;

  const EditCommunityRulesAndDiscriptionView({Key key, @required this.docId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditCommunityRulesAndDiscriptionViewModel>.reactive(
      onModelReady: (EditCommunityRulesAndDiscriptionViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        docId: docId,
      ),
      builder: (BuildContext context,
          EditCommunityRulesAndDiscriptionViewModel viewModel, Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Edit'),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    child: Row(
                      children: [
                        Tooltip(
                          message: 'Comunity rules',
                          child: Text(
                            'Comunity rules',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 45,
                          height: 45,
                          child: OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Long press to remove.')));
                            },
                            onLongPress: () {},
                            child: Icon(
                              Icons.remove,
                              size: 15,
                            ),
                            style: OutlinedButton.styleFrom(
                              primary: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          child: ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.add,
                                size: 15,
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: StreamBuilder(
                          stream: viewModel.getCommunityInformation(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 0, right: 4, bottom: 10),
                                  child: snapshot.data.docs[0]['rules'] !=
                                              null ||
                                          snapshot.data.docs[0]['rules']
                                                  .length >
                                              0
                                      ? Tooltip(
                                          message: 'Comunity Rules are: ' +
                                              snapshot.data.docs[0]['rules']
                                                  .join(', '),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount: snapshot
                                                  .data.docs[0]['rules'].length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      12.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 10,
                                                          height: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 7,
                                                        ),
                                                        Expanded(
                                                            child: TextFormField(
                                                                initialValue: snapshot
                                                                    .data
                                                                    .docs[0][
                                                                        'rules']
                                                                        [index]
                                                                    .toString())),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )),
                                          ),
                                        )
                                      : Tooltip(
                                          message: 'Rules are not set 😄',
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                    'Rules are not set 😄'),
                                              ),
                                            ),
                                          ),
                                        ));
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    child: Row(
                      children: [
                        Tooltip(
                          message: 'Comunity description',
                          child: Text(
                            'Comunity description',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                    stream: viewModel.getCommunityInformation(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs[0]['comunityDescription'] !=
                            null)
                          return Tooltip(
                            message: snapshot.data.docs[0]
                                ['comunityDescription'],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: TextFormField(
                                    initialValue: snapshot.data.docs[0]
                                        ['comunityDescription'],
                                    minLines: 2,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Color(0xffE7E7E7)
                                          : Color(0xff656565).withOpacity(0.4),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            style: BorderStyle.solid,
                                            width: 0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            style: BorderStyle.solid,
                                            width: 0),
                                      ),
                                      focusColor: Color(0xffE7E7E7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, top: 12, right: 4, bottom: 10),
                          child: Tooltip(
                            message: 'No discription for this comunity 😄',
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child:
                                    Text('No discription for this comunity 😄'),
                              ),
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    },
                  ),
                  ElevatedButtonWidget(
                    text: 'Update',
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ));
      },
      viewModelBuilder: () => EditCommunityRulesAndDiscriptionViewModel(),
    );
  }
}
