import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiter_clone_appwrite_io/features/auth/view/signup_view.dart';
import '../../../constants/constant.dart';
import '../controller/auth_controller.dart';

abstract class SignUpViewModel extends ConsumerState {
  final cntrlr1 = TextEditingController();
  final cntrlr2 = TextEditingController();
  final appBar = UIConstant.appBar();

  @override
  void dispose() {
    super.dispose();
    cntrlr1.dispose();
    cntrlr2.dispose();
  }

  void signUp() {
    ref
        .read(authApiController.notifier)
        .signUp(email: cntrlr1.text, password: cntrlr2.text, ctx: context);
  }

  static MaterialPageRoute route(){
    return MaterialPageRoute(builder: (context){
      return const SignUpView();
    });
  }
}
