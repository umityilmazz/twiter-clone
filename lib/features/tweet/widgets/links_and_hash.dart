// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:twiter_clone_appwrite_io/theme/palette.dart';
import '../../../core/utils.dart';

class LinkAndHashtags extends StatelessWidget {
  final String tweetText;
  const LinkAndHashtags({
    Key? key,
    required this.tweetText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<InlineSpan> textSpans = [];

    tweetText.split(" ").forEach(
      (word) {
        if (word.startsWith('#')) {
          textSpans.add(TextSpan(
              text: "$word ",
              style: const TextStyle(
                color: Pallete.blueColor,
                fontSize: 19,
              )));
        } else if (isLink(word)) {
          textSpans.add(TextSpan(
              text: "$word ",
              style: const TextStyle(
                color: Pallete.blueColor,
                fontSize: 19,
              )));
        } else {
          textSpans.add(TextSpan(
              text: "$word ",
              style: const TextStyle(
                color: Pallete.whiteColor,
                fontSize: 18,
              )));
        }
      },
    );

    return RichText(
        textAlign: TextAlign.start,
        softWrap: true,
        text: TextSpan(children: textSpans));
  }
}
