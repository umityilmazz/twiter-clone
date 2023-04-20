import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_extensions
void showSnackBar(BuildContext ctx, String content) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(content)));
}
extension emailToName on String {
  String getName() {
    return split('@')[0];
  }
}
void printDebugMode(String message, {StackTrace? st}) {
  if (kDebugMode) {
    print("Message : $message");
    print("Stactrace : $st");
  }
}
Future<List<File>> pickMultiImages() async {
  List<File> images = [];
  final imagePicker=ImagePicker();
  var chosenImages = await imagePicker.pickMultiImage();
  if (chosenImages.isNotEmpty) {
    for (var xfile in chosenImages) {
      images.add(File(xfile.path));
    }
  }
  return images;
}
bool isLink(String str) {
  RegExp linkRegex = RegExp(
    r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$",
    caseSensitive: false,
    multiLine: false,
  );
  return linkRegex.hasMatch(str);
}
List<String>? getLinkFromText(String text) {
  List<String> words = text.split(' ');
  List<String> links = [];
  if (words.isEmpty) {
    return null;
  }
  for (var word in words) {
    if (isLink(word)) {
      links.add(word);
    }
  }

  return links;
}
List<String>? getHashtagsFromText(String text) {
  List<String> words = text.split(' ');
  List<String> hashtags = [];
  if (words.isEmpty) {
    return null;
  }
  for (var word in words) {
    if (word.contains('#')) {
      hashtags.add(word);
    }
  }

  return hashtags;
}
