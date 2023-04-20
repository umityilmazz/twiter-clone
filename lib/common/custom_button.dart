import 'package:flutter/material.dart';
import '../theme/theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color bckgrColor;
  final Color textColor;
  final double height;
  final double width;

  const CustomButton(
      {this.textColor = Pallete.backgroundColor,
      this.bckgrColor = Pallete.whiteColor,
      this.height=30,
      this.width=100,
      required this.onTap,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: bckgrColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
