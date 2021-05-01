import 'package:boo_vi_app/widgets/smart_widgets/elevated_button/elevated_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/outlined_button/outlined_button_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:boo_vi_app/widgets/smart_widgets/underline_text/underline_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (BuildContext context, LoginViewModel viewModel, Widget _) {
        return Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: PageView(
                controller: viewModel.pageController,
                children: [
                  // ! Forgot Password

                  ListView(
                    children: [
                      SizedBox(
                        height: 160,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Forgot Password ?',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      TextfieldWidget(
                        controller: viewModel.forgotPasswordController,
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        // onSubmitted: (_) =>
                        //     viewModel.sendResetPasswordLink(context),
                      ),
                      SizedBox(
                        height: 128,
                      ),
                      viewModel.showForgotPasswordCircularProgressIndicator ==
                              true
                          ? Center(
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator()))
                          : Container(
                              height: 30,
                              width: 30,
                            ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButtonWidget(
                        text: 'Send Email',
                        onPressed: () =>
                            viewModel.sendResetPasswordLink(context),
                      )
                    ],
                  ),

                  // ! Login Page
                  ListView(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Hero(
                        tag: 'BooVi',
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/booViLogo-Red.png'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      TextfieldWidget(
                        controller: viewModel.loginEmailController,
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        // onSubmitted: (_) => viewModel.loginUser(context),
                      ),
                      TextfieldWidget(
                        controller: viewModel.loginPasswordController,
                        hintText: 'password',
                        obscureText: true,
                        // onSubmitted: (_) => viewModel.loginUser(context),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 2, right: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => viewModel.changePage(0),
                                child: UnderlineTextWidget(
                                    text: 'forgot password?'),
                              ),
                            ],
                          )),
                      viewModel.showLoginCircularProgressIndicator == true
                          ? Center(
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator()))
                          : Container(
                              height: 30,
                              width: 30,
                            ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButtonWidget(
                          text: 'Log In',
                          onPressed: () => viewModel.loginUser(context)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '- or -',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      OutlinedButtonWidget(
                        text: 'Sign Up',
                        onPressed: () => viewModel.changePage(2),
                      )
                    ],
                  ),

                  // ! Sign Up
                  ListView(
                    children: [
                      SizedBox(
                        height: 160,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      TextfieldWidget(
                        controller: viewModel.signUpEmailController,
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        //onSubmitted: (_) => viewModel.signUpUser(context),
                      ),
                      TextfieldWidget(
                        controller: viewModel.signUpPasswordController,
                        hintText: 'password',
                        obscureText: true,
                        // onSubmitted: (_) => viewModel.signUpUser(context),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      viewModel.showSignUpCircularProgressIndicator == true
                          ? Center(
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator()))
                          : Container(
                              height: 30,
                              width: 30,
                            ),
                      SizedBox(
                        height: 15,
                      ),
                      OutlinedButtonWidget(
                        text: 'Sign Up',
                        onPressed: () => viewModel.signUpUser(context),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
