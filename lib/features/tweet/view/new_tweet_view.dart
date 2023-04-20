import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twiter_clone_appwrite_io/common/custom_button.dart';
import 'package:twiter_clone_appwrite_io/common/loading_page.dart';
import 'package:twiter_clone_appwrite_io/constants/constant.dart';
import 'package:twiter_clone_appwrite_io/core/core.dart';
import 'package:twiter_clone_appwrite_io/theme/theme.dart';
import '../controller/tweet_controller.dart';

class NewTweetView extends ConsumerStatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return  NewTweetView();
    });
  }

  const NewTweetView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewTweetViewState();
}

class _NewTweetViewState extends ConsumerState<NewTweetView> {
  final controller = TextEditingController();
  List<File> images = [];

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(getCurrentUserDataProvider).value;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            // TWEET BUTTON
            CustomButton(
                onTap: () async {
                  final tw = ref.watch(tweetControllerProvider.notifier);
                  await tw.shareTweet(
                      ctx: context, tweet: controller.text, images: images);
                },
                text: 'Tweetle',
                bckgrColor: Pallete.blueColor,
                textColor: Pallete.whiteColor)
          ],
          // CLOSE BUTTON
          leading: IconButton(
              icon: const Icon(Icons.close, size: 35),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: user == null
            ? const LoadingPage()
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(user.profilPic),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //herkese açık button
                                staticButton(),
                                TextFormField(
                                  controller: controller,
                                  style: const TextStyle(fontSize: 25),
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(fontSize: 24),
                                      hintText: 'Neler oluyor?',
                                      border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          EdgeInsets.only(left: 10)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      // PİCKED IMAGES SLİDE
                      if (images.isNotEmpty)
                        CarouselSlider(
                            items: images
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Image.file(
                                        e,
                                        fit: BoxFit.fitWidth,
                                        width: 400,
                                      ),
                                    ))
                                .toList(),
                            options: CarouselOptions(
                              height: 300,
                              enableInfiniteScroll: false,
                            )),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: _newTweetbottomNavBar(),
      ),
    );
  }

  Container _newTweetbottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white24))),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                  onTap: _onPickImages,
                  child: SvgPicture.asset(AssetsConstants.galleryIcon)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(AssetsConstants.gifIcon),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(AssetsConstants.emojiIcon),
            ),
          ],
        ),
      ),
    );
  }

  Widget staticButton() => Padding(
        padding: const EdgeInsets.only(left: 5),
        child: TextButton.icon(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.blue))),
          onPressed: () {},
          icon: const Text('Herkese Açik'),
          label: const Icon(Icons.expand_more_sharp),
        ),
      );

  void _onPickImages() async {
    images = await pickMultiImages();

    setState(() {});
  }
}
