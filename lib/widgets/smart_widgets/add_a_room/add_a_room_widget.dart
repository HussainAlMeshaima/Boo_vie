import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'add_a_room_view_model.dart';

class AddARoomWidget extends StatelessWidget {
  final String docId;

  const AddARoomWidget({
    Key key,
    @required this.docId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddARoomViewModel>.reactive(
      onModelReady: (AddARoomViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        docId: docId,
      ),
      builder: (BuildContext context, AddARoomViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Tooltip(
                message: 'Type the new room name',
                child: ListTile(
                  title: Text(
                    'Type the new room name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 12),
                    child: Tooltip(
                      message: 'A door',
                      child: Container(
                        width: 110,
                        height: 190,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadiusDirectional.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                height: 38,
                                width: 18,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/doorHandleWhite.png'))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: 215,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Tooltip(
                            message: viewModel.roomController.text,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 23),
                              child: Text(viewModel.roomController.text),
                            ),
                          ),
                          TextfieldWidget(
                              hintText: 'Room name',
                              maxLines: 6,
                              controller: viewModel.roomController,
                              onChanged: (char) {
                                viewModel.getControlerOnCange(char);
                              },
                              onSubmitted: (String newShelfName) async {
                                if (viewModel.roomController.text.isEmpty) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please add a name to room')));
                                } else {
                                  Navigator.of(context).pop();
                                  viewModel.createARoomInThatComunity();
                                }
                              }),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              OutlinedButtonWidget(
                text: 'Create',
                onPressed: () {
                  if (viewModel.roomController.text.isEmpty) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please add a name to room')));
                  } else {
                    Navigator.of(context).pop();
                    viewModel.createARoomInThatComunity();
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => AddARoomViewModel(),
    );
  }
}
