import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twiter_clone_appwrite_io/constants/appwrite_constant.dart';
import 'package:twiter_clone_appwrite_io/core/core.dart';
import 'package:twiter_clone_appwrite_io/models/user_model.dart';

final userApiProvider = Provider<UserApi>((ref) {
  return UserApi(ref.watch(databeseProvider));
});

abstract class IUserApi {
  FutureVoid saveUser(UserModel user);
  Future<models.Document> getUserData(String userId);
}

class UserApi implements IUserApi {
  UserApi(Databases db) : _db = db;
 final Databases _db;
  @override
  FutureVoid saveUser(UserModel user) async {
    try {
      await _db.createDocument(
          databaseId: AppWriteConstant.databeseId,
          collectionId: AppWriteConstant.usersCollectionId,
          documentId: user.uid!,
          data: user.toMap());
      return right(null);
    } on AppwriteException catch (e, st) {
      print("${e.message}" + "${e.code} ");
      return left(Failrue(message: e.toString(), stackTrace: st));
    }
  }

  @override
  Future<models.Document> getUserData(String userId)  async{
    final documentUser = await _db.getDocument(
        databaseId: AppWriteConstant.databeseId,
        collectionId: AppWriteConstant.usersCollectionId,
        documentId: userId);
    return documentUser;
  }
}
