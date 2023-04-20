import 'package:twiter_clone_appwrite_io/core/enums/tweet_type_enum.dart';

extension ConvertToEnum on String {
  TweetType toEnum() {
    switch (this) {
      case 'text':
        return TweetType.text;
      case 'image':
        return TweetType.image;
      default:
        return TweetType.text;
    }
  }
}

