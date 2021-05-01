import 'package:boo_vi_app/widgets/dumb_widgets/list_tile/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'profile_to_edit_details_view_model.dart';

class ProfileToEditDetailsView extends StatelessWidget {
  final String userImage;

  const ProfileToEditDetailsView({Key key, @required this.userImage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileToEditDetailsViewModel>.reactive(
      onModelReady: (ProfileToEditDetailsViewModel viewModel) =>
          viewModel.handleStartUpLogic(userImage: userImage),
      builder: (BuildContext context, ProfileToEditDetailsViewModel viewModel,
          Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Edit page'),
            ),
            body: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 180,
                              child: ListView(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Choose Image Source:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ListTileWidget(
                                    text: 'From Camera',
                                    // onTap: () =>
                                    //     viewModel.selectImageFromCamra(context),
                                    leadingIconData: Icons.camera,
                                  ),
                                  ListTileWidget(
                                    text: 'From Gallery',
                                    // onTap: () =>
                                    //     viewModel.selectImageFromGallery(context),
                                    leadingIconData: Icons.photo,
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: viewModel.selectedImage != null
                        ? Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Color(0xffE7E7E7)
                                    : Color(0xff656565).withOpacity(0.4),
                                image: DecorationImage(
                                    image: FileImage(viewModel.selectedImage),
                                    fit: BoxFit.cover)),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: Container(
                                    height: 37,
                                    width: 37,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context).primaryColor),
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Color(0xffE7E7E7)
                                  : Color(0xff656565).withOpacity(0.4),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: Container(
                                    height: 37,
                                    width: 37,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context).primaryColor),
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ));
      },
      viewModelBuilder: () => ProfileToEditDetailsViewModel(),
    );
  }
}
