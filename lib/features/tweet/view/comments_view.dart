// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twiter_clone_appwrite_io/common/loading_page.dart';
import 'package:twiter_clone_appwrite_io/constants/assets_constant.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/controller/tweet_controller.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/widgets/image_preview_widget.dart';
import 'package:twiter_clone_appwrite_io/models/tweet_model.dart';
import 'package:twiter_clone_appwrite_io/models/user_model.dart';
import 'package:twiter_clone_appwrite_io/theme/palette.dart';

class CommentsView extends ConsumerWidget {
  static MaterialPageRoute route(TweetModel tweetModel) {
    return MaterialPageRoute(builder: (context) {
      return CommentsView(
        tweetModel: tweetModel,
      );
    });
  }

  final TweetModel tweetModel;
  const CommentsView({
    super.key,
    required this.tweetModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> iconPaths = [
      AssetsConstants.commentIcon,
      AssetsConstants.retweetIcon,
      AssetsConstants.likeOutlinedIcon,
      AssetsConstants.gifIcon,
    ];
    final user = ref.watch(getUserDataProvider(tweetModel.userId)).value;
    return user != null
        ? SafeArea(
            child: Scaffold(
              appBar: _appBar(context),
              bottomNavigationBar: _bottomTextField(),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _tweetUserImageAndName(user),
                      _tweetText(),
                      const SizedBox(height: 5),
                      if (tweetModel.images.isNotEmpty)
                        ImagePreviewWidget(tweetModel: tweetModel),
                      const SizedBox(height: 10),
                      _staticViewsCount(),
                      const SizedBox(height: 10),
                      _likeCountBar(),
                      const SizedBox(height: 10),
                      _iconBar(iconPaths),
                      const SizedBox(height: 10),
                      
                    ],
                  ),
                ),
              ),
            ),
          )
        : const LoadingPage();
  }

  Widget _iconBar(List<String> iconPaths) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...iconPaths
                .map((e) => SvgPicture.asset(
                      e,
                      color: Pallete.greyColor,
                    ))
                .toList(),
            Icon(
              Icons.share,
              color: Pallete.greyColor,
            )
          ],
        ),
      ),
    );
  }

  Container _likeCountBar() {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: Pallete.greyColor, width: 0.2),
              bottom: BorderSide(color: Pallete.greyColor, width: 0.3))),
      child: Padding(
          padding: const EdgeInsets.only(
            top: 7,
          ),
          child: Text.rich(TextSpan(
              text: '${tweetModel.likes.length}',
              style: const TextStyle(color: Pallete.whiteColor, fontSize: 17),
              children: const [
                TextSpan(
                    text: '  Beğeni  ',
                    style: TextStyle(color: Pallete.greyColor))
              ]))),
    );
  }

  Container _bottomTextField() {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Pallete.greyColor, width: 0.3),
                bottom: BorderSide(color: Pallete.greyColor, width: 0.3))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: const [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Yanıtını Twetle",
                      hintMaxLines: null,
                      hintStyle: TextStyle(fontSize: 18, letterSpacing: 0.6)),
                ),
              ),
              Icon(
                Icons.photo_camera_outlined,
                color: Pallete.blueColor,
              )
            ],
          ),
        ));
  }

  Text _staticViewsCount() {
    return const Text.rich(TextSpan(
        text: '22:31 - 19 Nis 23 saatinde ',
        style: TextStyle(
          color: Pallete.greyColor,
          fontSize: 17,
        ),
        children: [
          TextSpan(
              text: ' 1.539 ',
              style: TextStyle(
                  color: Pallete.whiteColor, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'Görüntülenme',
                    style: TextStyle(
                        color: Pallete.greyColor,
                        fontWeight: FontWeight.normal)),
              ])
        ]));
  }

  ListTile _tweetUserImageAndName(UserModel user) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(user.profilPic),
      ),
      title: Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Text(user.email),
    );
  }

  Widget _tweetText() {
    return Text(
      tweetModel.text,
      style: const TextStyle(
          fontSize: 22, letterSpacing: 0.6, fontWeight: FontWeight.w400),
    );
  }

  PreferredSize _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: ListTile(
        minLeadingWidth: 50,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_sharp, size: 30),
        ),
        title: const Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            "Tweet",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: 0.7),
          ),
        ),
      ),
    );
  }
}
