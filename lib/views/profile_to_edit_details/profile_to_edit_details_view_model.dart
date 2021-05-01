import 'dart:async';
import 'dart:io';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/core/services/cloudStorageServices.dart';
import 'package:boo_vi_app/core/services/imageSelectorService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileToEditDetailsViewModel extends BaseViewModel {
  Logger log;

  ProfileToEditDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  List<String> _options = [
    'Arts & entertainment',
    'Biographies & memoirs',
    'Childrens books',
    'Comics',
    'Computers & technology',
    'Cooking & food',
    'Fiction & literature',
    'Health, mind & body',
    'History',
    'Home & garden',
    'Mystery & thrillers',
    'Science fiction & fantasy',
    'Sports',
    'Travel',
  ];
  List<bool> _isChoiceChipSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  List<String> get options => _options;
  List<bool> get isChoiceChipSelected => _isChoiceChipSelected;

  swichChoiceChip(int index) {
    _isChoiceChipSelected[index] = !_isChoiceChipSelected[index];
    print(index);
    notifyListeners();
  }

  handleStartUpLogic({String userImage}) {}

  String _userImage;
  String get userImage => _userImage;

  // Future selectImageFromCamra(BuildContext context) async {
  //   Navigator.pop(context);

  //   Timer(Duration(milliseconds: 500), () {
  //     _isLoading = true;
  //     notifyListeners();
  //   });

  //   PickedFile newSelectImageFromCamra =
  //       await _imageSelectorService.selectImageFromCamra();

  //   if (newSelectImageFromCamra != null) {
  //     _selectedImage = File(newSelectImageFromCamra.path);

  //     _imageUrl = await _cloudStorageService.uploadAnImage(
  //         image: _selectedImage, userEmail: _userEmailController.text);
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  // }

  // Future selectImageFromGallery(BuildContext context) async {
  //   Navigator.pop(context);
  //   Timer(Duration(milliseconds: 500), () {
  //     _isLoading = true;
  //     notifyListeners();
  //   });
  //   PickedFile newSelectImageFromGallery =
  //       await _imageSelectorService.selectImageFromGallery();

  //   if (newSelectImageFromGallery != null) {
  //     _selectedImage = File(newSelectImageFromGallery.path);

  //     _imageUrl = await _cloudStorageService.uploadAnImage(
  //         image: _selectedImage, userEmail: _userEmailController.text);
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  // }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  File _selectedImage;
  File get selectedImage => _selectedImage;
  String _imageUrl;

  ImageSelectorService _imageSelectorService = locator<ImageSelectorService>();

  TextEditingController _userEmailController = TextEditingController(text: '');
  TextEditingController get userEmailController => _userEmailController;
  TextEditingController _displayedNameController =
      TextEditingController(text: '');
  TextEditingController get displayedNameController => _displayedNameController;
  TextEditingController _aboutMeController = TextEditingController(text: '');
  TextEditingController get aboutMeController => _aboutMeController;
}
