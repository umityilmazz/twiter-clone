// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twiter_clone_appwrite_io/constants/appwrite_constant.dart';
import 'package:twiter_clone_appwrite_io/core/core.dart';
import 'package:twiter_clone_appwrite_io/models/tweet_model.dart';
import 'package:twiter_clone_appwrite_io/models/user_model.dart';

final tweetApiProvider = Provider<TweetApi>((ref) {
  return TweetApi(
      realtime: ref.watch(realtimeProvider), db: ref.watch(databeseProvider));
});

final getLatestTweetsProvider = StreamProvider<RealtimeMessage>(
  (ref) {
    return ref.watch(tweetApiProvider).getLatestTweets();
  },
);

abstract class ITweetApi {
  FutureEither<models.Document> saveTweet({required TweetModel tweet});
  Future<List<models.Document>> getDocuments();
  Stream<RealtimeMessage> getLatestTweets();
  FutureEither<models.Document> likeTweet(TweetModel tweet);
  FutureEither<models.Document> retWeet(TweetModel tweet);
}

class TweetApi implements ITweetApi {
  TweetApi({required Realtime realtime, required Databases db})
      : _db = db,
        _realtime = realtime,
        super();
  final Databases _db;
  final Realtime _realtime;

  @override
  FutureEither<models.Document> saveTweet({required TweetModel tweet}) async {
    try {
      models.Document doc = await _db.createDocument(
          databaseId: AppWriteConstant.databeseId,
          collectionId: AppWriteConstant.tweetsCollectionId,
          documentId: ID.unique(),
          data: tweet.toMap());
      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(Failrue(message: "${e.message}", stackTrace: st));
    }
  }

  @override
  Future<List<models.Document>> getDocuments() async {
    var doc = await _db.listDocuments(
        queries: [Query.orderDesc('tweetedDate')],
        databaseId: AppWriteConstant.databeseId,
        collectionId: AppWriteConstant.tweetsCollectionId);

    return doc.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestTweets() {
    return _realtime.subscribe([
      'databases.6434cd80d6bf32524167.collections.643b15a258a3f5b2b5d3.documents'
    ]).stream;
  }

  @override
  FutureEither<models.Document> likeTweet(TweetModel tweet) async {
    try {
      final doc = await _db.updateDocument(
          databaseId: AppWriteConstant.databeseId,
          collectionId: AppWriteConstant.tweetsCollectionId,
          documentId: tweet.tweetUid,
          data: {'likes': tweet.likes});
      return right(doc);
    } catch (e, st) {
      return left(Failrue(message: e.toString(), stackTrace: st));
    }
  }

  @override
  FutureEither<models.Document> retWeet(TweetModel tweet) async {
    try {
      final doc = await _db.updateDocument(
          databaseId: AppWriteConstant.databeseId,
          collectionId: AppWriteConstant.tweetsCollectionId,
          documentId: tweet.tweetUid,
          data: {
            'retWeet': tweet.retWeet,
          });
      return right(doc);
    } catch (e, st) {
      return left(Failrue(message: e.toString(), stackTrace: st));
    }
  }
}
