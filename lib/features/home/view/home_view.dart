import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twiter_clone_appwrite_io/constants/constant.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/view/new_tweet_view.dart';
import 'package:twiter_clone_appwrite_io/theme/palette.dart';

class HomeView extends ConsumerStatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return const HomeView();
    });
  }

  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  var index = 0;
  void _onChangedBottomNavBar(int val) {
    setState(() {
      index = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UIConstant.appBar(),
        body: IndexedStack(index: index, children: UIConstant.screens),
        floatingActionButton: FloatingActionButton(
          child:
              const Icon(Icons.add, color: Pallete.backgroundColor, size: 30),
          onPressed: () {
            Navigator.of(context).push(
              NewTweetView.route(),
            );
          },
        ),
        bottomNavigationBar: _bottomNavBar());
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Pallete.backgroundColor,
      currentIndex: index,
      onTap: _onChangedBottomNavBar,
      items: [
        BottomNavigationBarItem(
            backgroundColor: Pallete.whiteColor,
            icon: SvgPicture.asset(
                color: Pallete.whiteColor,
                index == BotNavBarItems.home.index
                    ? AssetsConstants.homeFilledIcon
                    : AssetsConstants.homeOutlinedIcon),
            label: ""),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
                color: Pallete.whiteColor, AssetsConstants.searchIcon),
            label: ""),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
                color: Pallete.whiteColor,
                index == BotNavBarItems.notifiy.index
                    ? AssetsConstants.notifFilledIcon
                    : AssetsConstants.notifOutlinedIcon),
            label: ""),
      ],
    );
  }
}

enum BotNavBarItems { home, search, notifiy }
