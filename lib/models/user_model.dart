// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String name;
  final String email;
  final List<String> followers;
  final List<String> following;
  final String bio;
  final String bannerPic;
  final String profilPic;
  final String? uid;
  final bool isTwiterBlue;
  const UserModel(
      {required this.name,
      required this.email,
      required this.followers,
      required this.following,
      required this.bio,
      required this.bannerPic,
      required this.profilPic,
      this.isTwiterBlue = false,
      this.uid});

  UserModel copyWith({
    String? name,
    String? email,
    List<String>? followers,
    List<String>? following,
    String? bio,
    String? bannerPic,
    String? profilPic,
    bool? isTwiterBlue,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
      bannerPic: bannerPic ?? this.bannerPic,
      profilPic: profilPic ?? this.profilPic,
      isTwiterBlue: isTwiterBlue ?? this.isTwiterBlue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'followers': followers,
      'following': following,
      'bio': bio,
      'bannerPic': bannerPic,
      'profilPic': profilPic,
      'isTwiterBlue': isTwiterBlue,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      followers: List<String>.from(map['followers'] ),
      following: List<String>.from(map['following'] ),
      bio: map['bio'] as String,
      bannerPic: map['bannerPic'] as String,
      profilPic: map['profilPic'] as String,
      uid: map['\$id'] as String,
      isTwiterBlue: map['isTwiterBlue'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, followers: $followers, following: $following, bio: $bio, bannerPic: $bannerPic, proiflPic: $profilPic, uid: $uid, isTwiterBlue: $isTwiterBlue)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.bio == bio &&
        other.bannerPic == bannerPic &&
        other.profilPic == profilPic &&
        other.uid == uid &&
        other.isTwiterBlue == isTwiterBlue;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        bio.hashCode ^
        bannerPic.hashCode ^
        profilPic.hashCode ^
        uid.hashCode ^
        isTwiterBlue.hashCode;
  }
}
