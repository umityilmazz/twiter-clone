import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiter_clone_appwrite_io/features/auth/viewmodel/signup_view_mode.dart';
import '../../../common/custom_button.dart';
import '../../../constants/constant.dart';
import '../../../theme/theme.dart';
import '../viewmodel/login_view_model.dart';
import '../widgets/login_textform_field.dart.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState createState() => _LoginViewState();
}

class _LoginViewState extends LoginViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginTextFormField(
                    controller: cntrlr1,
                    hintText: 'Email address',
                    inputType: TextInputType.emailAddress,
                    isObscure: false),
                UIConstant.h20,
                LoginTextFormField(
                    controller: cntrlr2,
                    hintText: 'Pasword',
                    inputType: TextInputType.text,
                    isObscure: true),
                UIConstant.h20,
                CustomButton(text: "Done", onTap: login),
                UIConstant.h20,
                Center(
                  child: RichText(
                    text: TextSpan(
                        style:const TextStyle(letterSpacing: 1.5),
                        text: 'Are you dont have a account?',
                        children: [
                          TextSpan(
                              text: ' Sign in',
                              style:const TextStyle(
                                  color: Pallete.blueColor, letterSpacing: 1.5),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushReplacement(
                                    context, SignUpViewModel.route()))
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/**
 controller: model conversation,talking with apis
 */