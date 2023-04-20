// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:twiter_clone_appwrite_io/models/tweet_model.dart';

class ImagePreviewWidget extends StatelessWidget {
  final TweetModel tweetModel;
  const ImagePreviewWidget({
    Key? key,
    required this.tweetModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return checkImages(tweetModel.images.length, tweetModel);
  }
}

Widget checkImages(int imagesLength, TweetModel tweetModel) {
  if (imagesLength == 1) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        tweetModel.images[0],
        fit: BoxFit.cover,
        height: 300,
        width: double.infinity,
      ),
    );
  } else if (imagesLength == 2) {
    return SizedBox(
      height: 300,
      child: Row(
        children: [
          Expanded(
              child: _tweetImageContainer(imagePath: tweetModel.images[0])),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: _tweetImageContainer(imagePath: tweetModel.images[1]))
        ],
      ),
    );
  } else if (imagesLength == 3) {
    return SizedBox(
        height: 300,
        child: Row(
          children: [
            _tweetImageContainer(imagePath: tweetModel.images[0]),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      child: _tweetImageContainer(
                          imagePath: tweetModel.images[1])),
                  Expanded(
                      child:
                          _tweetImageContainer(imagePath: tweetModel.images[2]))
                ],
              ),
            )
          ],
        ));
  } else if (imagesLength == 4) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: _tweetImageContainer(imagePath: tweetModel.images[0])),
              Expanded(
                  child: _tweetImageContainer(imagePath: tweetModel.images[1]))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _tweetImageContainer(imagePath: tweetModel.images[2]),
              ),
              Expanded(
                  child: _tweetImageContainer(imagePath: tweetModel.images[3]))
            ],
          ),
        ],
      ),
    );
  } else {
    return Container();
  }
}

Widget _tweetImageContainer({required String imagePath}) {
  return Container(
    height: 200,
    padding: const EdgeInsets.only(right: 10, bottom: 3),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(imagePath, fit: BoxFit.cover),
    ),
  );
}
