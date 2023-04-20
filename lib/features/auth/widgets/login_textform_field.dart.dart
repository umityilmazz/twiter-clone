import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class LoginTextFormField extends StatelessWidget {
  final bool isObscure;
  final TextInputType inputType;
  final TextEditingController controller;
  final String hintText;

  const LoginTextFormField(
      {required this.isObscure,
      required this.inputType,
      required this.controller,
      required this.hintText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: controller,
      
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:const BorderSide(color: Pallete.whiteColor))),
    );
  }
}
