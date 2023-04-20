import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/controller/tweet_controller.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/widgets/links_and_hash.dart';
import 'package:twiter_clone_appwrite_io/features/tweet/widgets/tweet_icons_bar.dart';
import 'package:twiter_clone_appwrite_io/models/tweet_model.dart';
import 'package:twiter_clone_appwrite_io/models/user_model.dart';
import '../../../core/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../view/comments_view.dart';
import 'image_preview_widget.dart';

class TweetCard extends ConsumerWidget {
  TweetCard({required this.tweetModel, super.key});
  final TweetModel tweetModel;

  List<String> hashtags = [];
  List<String> links = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? user = ref.watch(getUserDataProvider(tweetModel.userId)).value;
    return user != null
        ? GestureDetector(
            onTap: () {
              Navigator.of(context).push(CommentsView.route(tweetModel));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white24))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //PROFİL PICTURE
                  SizedBox(
                    height: 100,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(user.profilPic),
                    ),
                  ),
                  //NAME EMAİL...
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  _nameAndEmail(user),
                                  Center(
                                    child: Text(
                                      " . ${_formatTheTime(tweetModel.tweetedDate)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const Icon(Icons.more_vert_rounded)
                            ],
                          ),

                          //TWEET TEXT
                          LinkAndHashtags(tweetText: tweetModel.text),
                          //LINKPREVİEW
                          if (getLinkFromText(tweetModel.text)?.isNotEmpty ??
                              false)
                            AnyLinkPreview(
                              link:
                                  "https://${getLinkFromText(tweetModel.text)?[0]}",
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (tweetModel.images.isNotEmpty)
                            ImagePreviewWidget(tweetModel: tweetModel),
                          // Container(
                          //   padding:
                          //       const EdgeInsets.only(right: 10, bottom: 3),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(15),
                          //     child: Image.network(tweetModel.images[0],
                          //         fit: BoxFit.cover),
                          //   ),
                          // ),

                          // ICONS BAR
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: TweetIconsBar(
                                tweet: tweetModel,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : const CircularProgressIndicator();
  }

  String _formatTheTime(DateTime date) {
    return timeago.format(date, locale: "en_short");
  }

  // Text _textAndHashtags(TweetModel tweet) {
  //   return Text.rich(
  //     TextSpan(
  //         text: user.name,
  //         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
  //         children: <InlineSpan>[
  //           TextSpan(
  //             text: "  @${user.email.split('@gmail.com')[0]}",
  //             style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),
  //           ),
  //         ]),
  //   );
  // }
  Text _nameAndEmail(UserModel user) {
    return Text.rich(
      TextSpan(
          text: user.name,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
          children: <InlineSpan>[
            TextSpan(
              text: "  @${user.email.split('@gmail.com')[0]}",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),
            ),
          ]),
    );
  }
}
// user.email.split('@gmail.com')[0]