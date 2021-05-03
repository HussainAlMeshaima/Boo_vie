import 'package:boo_vi_app/widgets/dumb_widgets/list_tile/list_tile_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'user_details_view_model.dart';

class UserDetailsView extends StatelessWidget {
  final String userEmail;

  const UserDetailsView({Key key, this.userEmail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDetailsViewModel>.reactive(
      onModelReady: (UserDetailsViewModel viewModel) =>
          viewModel.handleStartUpLogic(userEmail),
      builder:
          (BuildContext context, UserDetailsViewModel viewModel, Widget _) {
        return Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
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
                                      onTap: () => viewModel
                                          .selectImageFromCamra(context),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color:
                                              Theme.of(context).primaryColor),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(viewModel.displayedNameController.text,
                        style: TextStyle(fontSize: 20)),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                            itemCount: viewModel.options.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => viewModel.swichChoiceChip(index),
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                              child: Text(
                                                  viewModel.options[index])),
                                        ),
                                        decoration: BoxDecoration(
                                            color:
                                                viewModel.isChoiceChipSelected[
                                                            index] ==
                                                        true
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Theme.of(context)
                                                        .cardColor,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                ),
                              );
                            }),
                      ),
                    ),
                    TextfieldWidget(
                      hintText: 'Displayed Name',
                      controller: viewModel.displayedNameController,
                      onChanged: (String char) {
                        viewModel.getUsernameOnChange(char);
                      },
                      onSubmitted: (_) async {
                        await viewModel.createNewUser(context);
                      },
                      iconData: Icons.edit,
                    ),
                    TextfieldWidget(
                      hintText: 'About me',
                      maxLines: 3,
                      controller: viewModel.aboutMeController,
                      iconData: Icons.edit,
                      onSubmitted: (_) async {
                        await viewModel.createNewUser(context);
                      },
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
                      text: 'Continue',
                      onPressed: () async {
                        await viewModel.createNewUser(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => UserDetailsViewModel(),
    );
  }
}
