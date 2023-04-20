import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twiter_clone_appwrite_io/apis/storage_api.dart';
import 'package:twiter_clone_appwrite_io/apis/tweet_api.dart';
import 'package:twiter_clone_appwrite_io/core/core.dart';
import 'package:twiter_clone_appwrite_io/core/enums/tweet_type_enum.dart';
import 'package:twiter_clone_appwrite_io/models/tweet_model.dart';
import 'package:twiter_clone_appwrite_io/theme/palette.dart';
import '../../../apis/user_api.dart';
import '../../../constants/assets_constant.dart';
import '../../../models/user_model.dart';
import '../../auth/controller/auth_controller.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  return TweetController(ref.watch(storageApiProvider),
      ref.watch(tweetApiProvider), ref.watch(userApiProvider), ref);
});

final getCurrentUserDataProvider = FutureProvider((ref) async {
  final tw = ref.watch(tweetControllerProvider.notifier);
  final id = ref.watch(currentUserProvider).value!.$id;
  final user = tw.getUserData(id);
  return user;
});

final getUserDataProvider = FutureProvider.family((ref, String id) {
  final tw = ref.watch(tweetControllerProvider.notifier);

  return tw.getUserData(id);
});
final getTweetsProvider = FutureProvider((ref) {
  final twCnt = ref.watch(tweetControllerProvider.notifier);
  return twCnt.getTweets();
});

class TweetController extends StateNotifier<bool> {
  TweetController(
    StorageApi storageApi,
    TweetApi tweetApi,
    UserApi userApi,
    Ref ref,
  )   : _storageApi = storageApi,
        _tweetApi = tweetApi,
        _userApi = userApi,
        _ref = ref,
        super(false);
  final UserApi _userApi;
  final StorageApi _storageApi;
  final TweetApi _tweetApi;
  final Ref _ref;

  Future likeTweet(
      UserModel currentUser, TweetModel tweet, BuildContext ctx) async {
    if (tweet.likes.contains(currentUser.uid)) {
      tweet.likes.remove(currentUser.uid);
    } else {
      tweet.likes.add(currentUser.uid!);
    }
    final res = await _tweetApi.likeTweet(tweet);
    res.fold((l) => showSnackBar(ctx, "LİKE ISLEMI BAŞARISIZ"), (r) => null);
  }

  Future retWeet(
      TweetModel tweet, UserModel currentUser, BuildContext ctx) async {
    //retweet yapmışşsa silme işlemi kontrolü
    bool isReetWeted = false;
    if (tweet.retWeet.contains(currentUser.uid)) {
      isReetWeted = true;
    }
    bool res;
    //Retweet geri alma işlemi
    if (isReetWeted) {
      res = await _showCustomBottomSheet(ctx, isReetWeted);
      if (res) {
        tweet.retWeet.remove(currentUser.uid);
        await _tweetApi.retWeet(tweet);
      } else {}
    }
    // retweet oluşturma işlemi
    else {
      res = await _showCustomBottomSheet(ctx, isReetWeted);
      if (res) {
        tweet.retWeet.add(currentUser.uid!);
        await _tweetApi.retWeet(tweet);
      } else {}
    }
  }

  Future<List<TweetModel>> getTweets() async {
    var docs = await _tweetApi.getDocuments();
    return docs.map((e) => TweetModel.fromMap(e.data)).toList();
  }

  Future<void> shareTweet({
    required BuildContext ctx,
    required String tweet,
    required List<File> images,
  }) {
    if (images.isNotEmpty) {
      _shareTweetWithImages(ctx: ctx, images: images, tweet: tweet);
    } else {
      _shareTweetOnlyText(ctx: ctx, tweet: tweet);
    }
    return Future.delayed(Duration(seconds: 1));
  }

  Future<void> _shareTweetWithImages({
    required BuildContext ctx,
    required String tweet,
    required List<File> images,
  }) async {
    List<String>? links = getLinkFromText(tweet);
    List<String>? hashtags = getHashtagsFromText(tweet);
    final userId = _ref.watch(currentUserProvider).value!.$id;

    final imagePaths = await _storageApi.storTheImages(images);

    TweetModel tw = TweetModel(
        text: tweet,
        hashtags: hashtags ?? [],
        links: links ?? [],
        commentsId: [],
        images: imagePaths,
        tweetType: TweetType.image,
        likes: [],
        tweetedDate: DateTime.now(),
        userId: userId,
        retWeet: []);

    final res2 = await _tweetApi.saveTweet(tweet: tw);
    res2.fold((l) => showSnackBar(ctx, 'Tweet Oluşturulamadı'), (r) {
      showSnackBar(ctx, 'Tweet Oluşturuldu');
      Navigator.of(ctx).pop();
    });
  }

  Future<void> _shareTweetOnlyText({
    required BuildContext ctx,
    required String tweet,
  }) async {
    state = true;
    List<String>? links = getLinkFromText(tweet);
    List<String>? hashtags = getHashtagsFromText(tweet);
    final userId = _ref.watch(currentUserProvider).value!.$id;
    TweetModel tw = TweetModel(
        text: tweet,
        hashtags: hashtags ?? [],
        links: links ?? [],
        commentsId: [],
        images: [],
        tweetType: TweetType.text,
        likes: [],
        tweetedDate: DateTime.now(),
        userId: userId,
        retWeet: []);
    var response = await _tweetApi.saveTweet(tweet: tw);
    response.fold((l) => showSnackBar(ctx, l.message), (r) async {
      showSnackBar(ctx, 'Tweet Oluşturuldu');
      Navigator.of(ctx).pop();
    });
    state = false;
  }

  Future<UserModel?> getUserData(String id) async {
    try {
      final document = await _userApi.getUserData(id);
      return UserModel.fromMap(document.data);
    } on AppwriteException {
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

Future<bool> _showCustomBottomSheet(BuildContext ctx, bool isRetWeted) async {
  var result = await showModalBottomSheet<bool>(
      backgroundColor: Pallete.backgroundColor,
      constraints: BoxConstraints(maxHeight: 200),
      context: ctx,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  15,
                ),
                topRight: Radius.circular(15)),
            color: Pallete.backgroundColor,
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  AssetsConstants.retweetIcon,
                  color: Pallete.whiteColor,
                ),
                title: isRetWeted
                    ? Text("Retwetlemeyi geri al")
                    : Text("Reetwetle"),
                onTap: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
              ListTile(
                leading: Icon(Icons.mode_edit_outline_outlined),
                title: Text("Tweeti Alıntıla"),
                onTap: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
            ],
          ),
        );
      });

  return result ?? false;
}
