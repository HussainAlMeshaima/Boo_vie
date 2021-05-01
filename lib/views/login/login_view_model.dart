import 'dart:async';

import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/router_constants.dart';
import 'package:boo_vi_app/core/services/authenticationService.dart';
import 'package:boo_vi_app/views/user_details/user_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  Logger log;

  LoginViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  NavigationService _navigationService = locator<NavigationService>();

  void changePage(pageIndex) async {
    await _pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 700), curve: Curves.easeInOut);
    notifyListeners();
  }

  loginUser(context) async {
    FocusScope.of(context).unfocus();
    _showLoginCircularProgressIndicator = true;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          await _authenticationService.signInWithEmailAndPassword(
            _loginEmailController.text.trim().trimLeft().trimRight(),
            _loginPasswordController.text.trim().trimLeft().trimRight(),
          ),
        ),
      ),
    );
    _showLoginCircularProgressIndicator = false;
    notifyListeners();
    pushStartUpView();
  }

  signUpUser(context) async {
    FocusScope.of(context).unfocus();
    _showSignUpCircularProgressIndicator = true;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          await _authenticationService.createUserWithEmailAndPassword(
            _signUpEmailController.text.trim().trimLeft().trimRight(),
            _signUpPasswordController.text.trim().trimLeft().trimRight(),
          ),
        ),
      ),
    );
    _showSignUpCircularProgressIndicator = false;
    notifyListeners();
    pushUserDetailsView();
  }

  sendResetPasswordLink(context) async {
    FocusScope.of(context).unfocus();
    _showForgotPasswordCircularProgressIndicator = true;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          await _authenticationService.sendResetPasswordLink(
            _forgotPasswordController.text.trim().trimLeft().trimRight(),
          ),
        ),
      ),
    );
    _showForgotPasswordCircularProgressIndicator = false;
    notifyListeners();
  }

  Future<void> pushUserDetailsView() async {
    if (await _authenticationService.hasUser()) {
      Timer(
          Duration(
            seconds: 3,
            milliseconds: 500,
          ), () async {
        _navigationService.replaceWithTransition(
            UserDetailsView(
              userEmail: _signUpEmailController.text,
            ),
            transition: 'rightToLeftWithFade');
      });
    }
  }

  Future<void> pushStartUpView() async {
    if (await _authenticationService.hasUser()) {
      Timer(Duration(seconds: 3), () async {
        _navigationService.pushNamedAndRemoveUntil(startUpViewRoute);
      });
    }
  }

  PageController _pageController = PageController(initialPage: 1);
  PageController get pageController => _pageController;

  TextEditingController _loginEmailController = TextEditingController(text: '');
  TextEditingController get loginEmailController => _loginEmailController;

  TextEditingController _loginPasswordController =
      TextEditingController(text: '');
  TextEditingController get loginPasswordController => _loginPasswordController;

  TextEditingController _signUpEmailController =
      TextEditingController(text: '');
  TextEditingController get signUpEmailController => _signUpEmailController;

  TextEditingController _signUpPasswordController =
      TextEditingController(text: '');
  TextEditingController get signUpPasswordController =>
      _signUpPasswordController;

  TextEditingController _forgotPasswordController =
      TextEditingController(text: '');
  TextEditingController get forgotPasswordController =>
      _forgotPasswordController;

  bool _showLoginCircularProgressIndicator = false;
  bool get showLoginCircularProgressIndicator =>
      _showLoginCircularProgressIndicator;

  bool _showForgotPasswordCircularProgressIndicator = false;
  bool get showForgotPasswordCircularProgressIndicator =>
      _showForgotPasswordCircularProgressIndicator;

  bool _showSignUpCircularProgressIndicator = false;
  bool get showSignUpCircularProgressIndicator =>
      _showSignUpCircularProgressIndicator;
}
