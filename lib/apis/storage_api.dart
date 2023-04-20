import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiter_clone_appwrite_io/constants/appwrite_constant.dart';
import 'package:twiter_clone_appwrite_io/core/core.dart';

final storageApiProvider = Provider((ref) {
  return StorageApi(ref.watch(storageProvider));
});

class StorageApi {
  StorageApi(Storage storage)
      : _storage = storage,
        super();

  final Storage _storage;

  Future<List<String>> storTheImages(List<File> images) async {
    List<String> imageLinks = [];
    

    for (final img in images) {
        var uploadedFile = await _storage.createFile(
          onProgress: (p0) {
            
          },
            bucketId: AppWriteConstant.imagesBucketId,
            fileId: ID.unique(),
            file: InputFile.fromPath(path: img.path,filename: img.path));
        String path = AppWriteConstant.getImageUrl(uploadedFile.$id);
        imageLinks.add(path);
    }
    return imageLinks;
  }
}
