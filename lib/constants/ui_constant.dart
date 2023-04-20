import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twiter_clone_appwrite_io/features/auth/view/test_logout.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/view/tweet_list.dart';

import '../theme/theme.dart';
import 'constant.dart';

class UIConstant {
  static AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        theme: SvgTheme(),
      ),
    );
  }

  static List<Widget> screens = [
    const TweetListView(),
    LogOutView(),
    Text("Notify Screen"),
  ];

  static SizedBox get h20 {
    return const SizedBox(
      height: 20,
    );
  }
}

