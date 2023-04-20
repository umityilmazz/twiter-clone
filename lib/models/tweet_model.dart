// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../core/enums/tweet_type_enum.dart';
import '../core/extensions/core_extensions.dart';

class TweetModel {
  final String text;
  final List<String> hashtags;
  final List<String> links;
  final List<String> commentsId;
  final List<String> images;
  final TweetType tweetType;
  final List<String> likes;
  final List<String> retWeet; // maybe later we will add a retweet accounts
  final DateTime tweetedDate;
  final String userId;
  final String tweetUid;
  TweetModel(
      {required this.text,
      required this.hashtags,
      required this.links,
      required this.commentsId,
      required this.images,
      required this.tweetType,
      required this.likes,
      required this.tweetedDate,
      required this.userId,
      this.tweetUid = "",
      required this.retWeet});

  TweetModel copyWith(
      {String? text,
      List<String>? hashtags,
      List<String>? links,
      List<String>? commentsId,
      List<String>? images,
      TweetType? tweetType,
      List<String>? likes,
      DateTime? tweetedDate,
      String? userId,
      String? tweetUid,
      List<String>? retWeet}) {
    return TweetModel(
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      links: links ?? this.links,
      commentsId: commentsId ?? this.commentsId,
      images: images ?? this.images,
      tweetType: tweetType ?? this.tweetType,
      likes: likes ?? this.likes,
      tweetedDate: tweetedDate ?? this.tweetedDate,
      userId: userId ?? this.userId,
      tweetUid: tweetUid ?? this.tweetUid,
      retWeet: retWeet ?? this.retWeet,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'hashtags': hashtags,
      'links': links,
      'commentsId': commentsId,
      'images': images,
      'tweetType': tweetType.type, // this give us a type name
      'likes': likes,
      'tweetedDate': tweetedDate.toString(),
      'retWeet': retWeet,
      'userId': userId
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      text: map['text'] as String,
      hashtags: List<String>.from((map['hashtags'] as List<dynamic>)),
      links: List<String>.from((map['links'] as List<dynamic>)),
      commentsId: List<String>.from((map['commentsId'] as List<dynamic>)),
      images: List<String>.from(map['images'] as List<dynamic>),
      tweetType: (map["tweetType"] as String).toEnum(),
      likes: List<String>.from(map['likes'] as List<dynamic>),
      retWeet: List<String>.from(map['retWeet'] as List<dynamic>),
      tweetedDate:
          DateTime.parse(map['tweetedDate']),
      userId: map['userId'] as String,
      tweetUid: map['\$id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModel.fromJson(String source) =>
      TweetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TweetModel(text: $text, hashtags: $hashtags, links: $links, commentsId: $commentsId, images: $images, tweetType: $tweetType, likeCount: $likes, tweetedDate: $tweetedDate, userId: $userId, tweetUid: $tweetUid)';
  }

  @override
  bool operator ==(covariant TweetModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        listEquals(other.hashtags, hashtags) &&
        listEquals(other.links, links) &&
        listEquals(other.commentsId, commentsId) &&
        listEquals(other.images, images) &&
        listEquals(other.likes, likes)&&
        listEquals(other.retWeet, retWeet)&&
        other.tweetType == tweetType &&
        other.tweetedDate == tweetedDate &&
        other.userId == userId &&
        other.tweetUid == tweetUid;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        hashtags.hashCode ^
        links.hashCode ^
        commentsId.hashCode ^
        images.hashCode ^
        tweetType.hashCode ^
        likes.hashCode ^
        tweetedDate.hashCode ^
        userId.hashCode ^
        tweetUid.hashCode;
  }
}
