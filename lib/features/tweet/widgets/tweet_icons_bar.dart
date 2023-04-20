// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:twiter_clone_appwrite_io/common/loading_page.dart';

import 'package:twiter_clone_appwrite_io/constants/assets_constant.dart';
import 'package:twiter_clone_appwrite_io/core/core.dart';
import 'package:twiter_clone_appwrite_io/features/auth/controller/auth_controller.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/controller/tweet_controller.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/view/comments_view.dart';
import 'package:twiter_clone_appwrite_io/models/tweet_model.dart';
import 'package:twiter_clone_appwrite_io/models/user_model.dart';
import 'package:twiter_clone_appwrite_io/theme/palette.dart';

class TweetIconsBar extends ConsumerWidget {
  const TweetIconsBar({
    Key? key,
    required this.tweet,
  }) : super(key: key);
  final TweetModel tweet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(getCurrentUserDataProvider).value;
    final tweetController = ref.watch(tweetControllerProvider.notifier);
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      if (currentUser != null) {
        await tweetController.likeTweet(currentUser, tweet, context);
      } else {
        showSnackBar(context, "like işlemi başarisiz");
        return isLiked;
      }
      return !isLiked;
    }

    return currentUser != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CommentsView.route(tweet));
                    },
                    child: SvgPicture.asset(
                      alignment: Alignment.center,
                      AssetsConstants.commentIcon,
                      color: Colors.grey,
                    ),
                  ),
                  Text(" 4")
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      tweetController.retWeet(tweet, currentUser, context);
                    },
                    child: SvgPicture.asset(
                      AssetsConstants.retweetIcon,
                      alignment: Alignment.center,
                      color: Colors.grey,
                    ),
                  ),
                  Text(tweet.retWeet.length.toString())
                ],
              ),
              // like button
              LikeButton(
                onTap: onLikeButtonTapped,
                animationDuration: Duration(seconds: 1),
                isLiked: tweet.likes.contains(currentUser.uid),
                likeCount: tweet.likes.length,
                size: 23,
                likeBuilder: (isLiked) {
                  return isLiked
                      ? SvgPicture.asset(
                          AssetsConstants.likeFilledIcon,
                          color: Pallete.redColor,
                        )
                      : SvgPicture.asset(
                          AssetsConstants.likeOutlinedIcon,
                          color: Pallete.greyColor,
                        );
                },
              ),

              // Row(
              //   children: [
              //     SvgPicture.asset(
              //       alignment: Alignment.center,
              //       AssetsConstants.likeOutlinedIcon,
              //       color: Colors.grey,
              //     ),
              //     Text(" 12")
              //   ],
              // ),
              Row(
                children: [
                  SvgPicture.asset(
                    alignment: Alignment.center,
                    AssetsConstants.viewsIcon,
                    color: Colors.grey,
                  ),
                  Text(" 192")
                ],
              ),
              Icon(
                Icons.share,
              )
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}
