import 'dart:async';
import 'dart:io';
import 'package:boo_vi_app/core/services/cloudStorageServices.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/router_constants.dart';
import 'package:boo_vi_app/core/services/ImageSelectorService.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class UserDetailsViewModel extends BaseViewModel {
  Logger log;

  UserDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  File _selectedImage;
  File get selectedImage => _selectedImage;
  String _imageUrl;

  ImageSelectorService _imageSelectorService = locator<ImageSelectorService>();
  CloudStorageServices _cloudStorageService = locator<CloudStorageServices>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future selectImageFromCamra(BuildContext context) async {
    Navigator.pop(context);

    PickedFile newSelectImageFromCamra =
        await _imageSelectorService.selectImageFromCamra();

    if (newSelectImageFromCamra != null) {
      _selectedImage = File(newSelectImageFromCamra.path);
      notifyListeners();
      _imageUrl = await _cloudStorageService.uploadAnImage(
          image: _selectedImage, userEmail: _userEmailController.text);
      notifyListeners();
    }
  }

  Future selectImageFromGallery(BuildContext context) async {
    Navigator.pop(context);

    PickedFile newSelectImageFromGallery =
        await _imageSelectorService.selectImageFromGallery();

    if (newSelectImageFromGallery != null) {
      _selectedImage = File(newSelectImageFromGallery.path);
      notifyListeners();
      _imageUrl = await _cloudStorageService.uploadAnImage(
          image: _selectedImage, userEmail: _userEmailController.text);
      notifyListeners();
    }
  }

  pushStartUpView(context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('User has been created successfully'),
      ),
    );

    if (await _authenticationService.hasUser())
      Timer(Duration(seconds: 4, milliseconds: 520), () async {
        _navigationService.pushNamedAndRemoveUntil(startUpViewRoute);
      });
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  createNewUserCatigoryName() {
    return _options.asMap().entries.forEach((element) => print(element));
  }

  createNewUser(context) async {
    int counter =
        _isChoiceChipSelected.where((element) => element == true).length;
    Map userMap = {};

    _options.asMap().entries.forEach((entry) {
      int idx = entry.key;
      String val = entry.value;
      String val2 = entry.value
              .replaceAll(' ', '')
              .replaceAll('&', 'and')
              .replaceAll(',', '')
              .toLowerCase() +
          'Books';

      Map m1 = {
        'catigoryName': val,
        'catigoryNameTrimed': val2,
        'isSelected': _isChoiceChipSelected[idx]
      };

      userMap[val2] = m1;
    });
    print(userMap);

    if (_selectedImage == null) {
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide an Image to be recognized')));
    }
    if (_displayedNameController.text.isEmpty) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please provide an Email')));
    }
    if (_aboutMeController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide a description about you')));
    }

    if (_aboutMeController.text.isNotEmpty &&
        _displayedNameController.text.isNotEmpty &&
        _selectedImage != null) {
      await _cloudFirestoreServices.createNewUser(
          uid: await _authenticationService.userId(),
          userName: _displayedNameController.text,
          userEmail: _userEmailController.text.toLowerCase(),
          userDescription: _aboutMeController.text,
          userImageUrl: _imageUrl,
          userCategories: userMap,
          totalNumberOfSelectedCategories: counter);
      pushStartUpView(context);
    }
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

  TextEditingController _userEmailController = TextEditingController(text: '');
  TextEditingController get userEmailController => _userEmailController;
  TextEditingController _displayedNameController =
      TextEditingController(text: '');
  TextEditingController get displayedNameController => _displayedNameController;
  TextEditingController _aboutMeController = TextEditingController(text: '');
  TextEditingController get aboutMeController => _aboutMeController;

  String getUsernameOnChange(char) {
    String word = _displayedNameController.text + char;
    notifyListeners();
    return word;
  }

  handleStartUpLogic(String userEmail) {
    _userEmailController.text = userEmail;
  }

  int numberOfSelcted() {
    return _isChoiceChipSelected.where((element) => element == true).length;
  }
}
