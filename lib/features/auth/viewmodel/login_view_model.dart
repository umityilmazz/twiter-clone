import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiter_clone_appwrite_io/features/auth/view/login_view.dart';
import '../../../constants/constant.dart';
import '../controller/auth_controller.dart';

abstract class LoginViewModel extends ConsumerState {
  final cntrlr1 = TextEditingController();
  final cntrlr2 = TextEditingController();
  final appBar = UIConstant.appBar();

  @override
  void dispose() {
    super.dispose();
    cntrlr1.dispose();
    cntrlr2.dispose();
  }

  void login() {
    ref
        .read(authApiController.notifier)
        .login(email: cntrlr1.text, password: cntrlr2.text,ctx: context);
  }

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) {
        return const LoginView();
      },
    );
  }
}
