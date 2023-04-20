import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiter_clone_appwrite_io/apis/tweet_api.dart';
import 'package:twiter_clone_appwrite_io/common/error_page.dart';
import 'package:twiter_clone_appwrite_io/common/loading_page.dart';
import 'package:twiter_clone_appwrite_io/constants/constant.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/controller/tweet_controller.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/widgets/tweet_card.dart';
import 'package:twiter_clone_appwrite_io/models/tweet_model.dart';

class TweetListView extends ConsumerWidget {
  const TweetListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
        data: (tweets) {
          return ref.watch(getLatestTweetsProvider).when(
              // ilk uygulama açılırken data yok sayıyor o yzüden loading kısmına koyduk
              data: (stream) {
                if (stream.events.contains(
                    'databases.*.collections.${AppWriteConstant.tweetsCollectionId}.documents.*.create')) {
                  tweets.insert(0, TweetModel.fromMap(stream.payload));
                }
                if (stream.events.contains(
                    'databases.*.collections.${AppWriteConstant.tweetsCollectionId}.documents.*.update')) {
                  tweets = tweets;
                }
                return ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  itemCount: tweets.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("if events kontolü sonraki listview");
                    var tweet = tweets[index];
                    return TweetCard(tweetModel: tweet);
                  },
                );
              },
              error: (e, st) => ErrorPage(),
              loading: () => ListView.builder(
                  shrinkWrap: true,

                    padding: const EdgeInsets.symmetric(vertical: 5),
                    itemCount: tweets.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("if events kontolü sonraki listview");
                      var tweet = tweets[index];
                      return TweetCard(tweetModel: tweet);
                    },
                  ));
        },
        error: (e, st) => ErrorPage(),
        loading: () => LoadingPage());
  }
}
