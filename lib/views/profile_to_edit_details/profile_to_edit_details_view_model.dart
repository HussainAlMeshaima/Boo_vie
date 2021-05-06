import 'dart:async';
import 'dart:io';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/services/cloudStorageServices.dart';
import 'package:boo_vi_app/core/services/imageEditService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';

class ProfileToEditDetailsViewModel extends BaseViewModel {
  Logger log;

  ProfileToEditDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  handleStartUpLogic(
      {@required String userImage,
      @required String userDescription,
      @required String userName}) {
    _userImage = userImage;
    _userDescription = userDescription;
    _userName = userName;
    _displayedNameController.text = userName;
    _aboutMeController.text = userDescription;
  }

  String updateAndNotifyListenersForDisplayedNameController(char) {
    String word = _displayedNameController.text + char;
    notifyListeners();
    return word;
  }

  swichChoiceChip(int index) async {
    _isSelected[index] = !_isSelected[index];

    notifyListeners();
  }

  Future<DocumentSnapshot> getUserCategories() async {
    DocumentSnapshot doc = await _cloudFirestoreServices.getUserCategories();

    _userCategoriesMap = doc.data()['userCategories'];
    userCategoriesMap.forEach(
      (key, value) {
        _catigoryNameTrimed.add(value['catigoryNameTrimed']);
        _catigoryName.add(value['catigoryName']);
        _isSelected.add(value['isSelected']);
      },
    );

    return doc;
  }

  generateANewMap() async {
    Map<String, dynamic> emptyMap = {};
    _catigoryName.asMap().entries.forEach((entry) {
      int idx = entry.key;
      String val = entry.value;
      String val2 = entry.value
              .replaceAll(' ', '')
              .replaceAll('&', 'and')
              .replaceAll(',', '')
              .toLowerCase() +
          'Books';

      Map<String, dynamic> m1 = {
        'catigoryName': val,
        'catigoryNameTrimed': val2,
        'isSelected': _isSelected[idx]
      };

      emptyMap[val2] = m1;
    });
    await _cloudFirestoreServices.updateThatMap(emptyMap);
  }

  Future selectImageFromCamra(BuildContext context) async {
    Navigator.pop(context);

    Timer(Duration(milliseconds: 500), () {
      _isLoading = true;
      notifyListeners();
    });

    PickedFile newSelectImageFromCamra =
        await _imageEditService.selectImageFromCamra();

    if (newSelectImageFromCamra != null) {
      _selectedImage = File(newSelectImageFromCamra.path);

      _imageUrl = await _cloudStorageService.uploadAnImage(
          image: _selectedImage, userEmail: _userEmailController.text);

      _cloudFirestoreServices.updateUserImage(_imageUrl);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future selectImageFromGallery(BuildContext context) async {
    Navigator.pop(context);
    Timer(Duration(milliseconds: 500), () {
      _isLoading = true;
      notifyListeners();
    });
    PickedFile newSelectImageFromGallery =
        await _imageEditService.selectImageFromGallery();

    if (newSelectImageFromGallery != null) {
      _selectedImage = File(newSelectImageFromGallery.path);

      _imageUrl = await _cloudStorageService.uploadAnImage(
          image: _selectedImage, userEmail: _userEmailController.text);

      _cloudFirestoreServices.updateUserImage(_imageUrl);
    }
    _isLoading = false;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  File _selectedImage;
  File get selectedImage => _selectedImage;
  String _imageUrl;
  String get imageUrl => _imageUrl;

  String _userImage;
  String get userImage => _userImage;
  String _userEmail;
  String get userEmail => _userEmail;
  String _userName;
  String get userName => _userName;
  String _userDescription;
  String get userDescription => _userDescription;
  Map<String, dynamic> _userCategoriesMap;
  Map<String, dynamic> get userCategoriesMap => _userCategoriesMap;

  List<String> _catigoryName = [];
  List<String> get catigoryName => _catigoryName;
  List<String> _catigoryNameTrimed = [];
  List<String> get catigoryNameTrimed => _catigoryNameTrimed;
  List<bool> _isSelected = [];
  List<bool> get isSelected => _isSelected;

  ImageEditService _imageEditService = locator<ImageEditService>();
  CloudStorageServices _cloudStorageService = locator<CloudStorageServices>();
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  TextEditingController _userEmailController = TextEditingController(text: '');
  TextEditingController get userEmailController => _userEmailController;
  TextEditingController _displayedNameController =
      TextEditingController(text: '');
  TextEditingController get displayedNameController => _displayedNameController;
  TextEditingController _aboutMeController = TextEditingController(text: '');
  TextEditingController get aboutMeController => _aboutMeController;
}
