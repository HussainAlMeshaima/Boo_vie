import 'package:boo_vi_app/widgets/dumb_widgets/list_tile/list_tile_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'profile_to_edit_details_view_model.dart';

class ProfileToEditDetailsView extends StatelessWidget {
  final String userImage;
  final String userName;
  final String userDescription;

  const ProfileToEditDetailsView({
    Key key,
    @required this.userImage,
    @required this.userName,
    @required this.userDescription,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileToEditDetailsViewModel>.reactive(
      onModelReady: (ProfileToEditDetailsViewModel viewModel) =>
          viewModel.handleStartUpLogic(
        userImage: userImage,
        userName: userName,
        userDescription: userDescription,
      ),
      builder: (BuildContext context, ProfileToEditDetailsViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit page'),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                SizedBox(
                  height: 30,
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
                                    onTap: () =>
                                        viewModel.selectImageFromCamra(context),
                                    leadingIconData: Icons.camera,
                                  ),
                                  ListTileWidget(
                                    text: 'From Gallery',
                                    onTap: () => viewModel
                                        .selectImageFromGallery(context),
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
                                  fit: BoxFit.cover),
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
                                    child: Icon(Icons.edit,
                                        color: Theme.of(context)
                                            .primaryIconTheme
                                            .color),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Hero(
                            tag: viewModel.userImage,
                            child: Container(
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
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(viewModel.userImage))),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Icon(Icons.edit,
                                          color: Theme.of(context)
                                              .primaryIconTheme
                                              .color),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                FutureBuilder(
                  future: viewModel.getUserCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          SizedBox(height: 20),
                          Text(viewModel.displayedNameController.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 20),
                          Container(
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ListView.builder(
                                  itemCount: 14,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () =>
                                          viewModel.swichChoiceChip(index),
                                      child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Container(
                                              height: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Center(
                                                    child: Text(viewModel
                                                        .catigoryName[index])),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: viewModel.isSelected[
                                                              index] ==
                                                          true
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Theme.of(context)
                                                          .cardColor,
                                                  border:
                                                      Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            )),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextfieldWidget(
                            hintText: 'Displayed Name',
                            controller: viewModel.displayedNameController,
                            onChanged: (String char) {
                              viewModel
                                  .updateAndNotifyListenersForDisplayedNameController(
                                      char);
                            },
                            onSubmitted: (_) async {
                              viewModel.notifyListeners();
                            },
                            iconData: Icons.edit,
                          ),
                          TextfieldWidget(
                            hintText: 'About me',
                            maxLines: 3,
                            controller: viewModel.aboutMeController,
                            iconData: Icons.edit,
                            onSubmitted: (_) async {},
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          viewModel.isLoading
                              ? Center(
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator()))
                              : Center(
                                  child: Container(
                                  height: 30,
                                  width: 30,
                                )),
                          SizedBox(
                            height: 15,
                          ),
                          OutlinedButtonWidget(
                            text: 'Update',
                            onPressed: () {
                              viewModel.generateANewMap();
                            },
                          )
                        ],
                      );
                    }

                    return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileToEditDetailsViewModel(),
    );
  }
}
