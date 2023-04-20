import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../core/core.dart';

// PROVIDERS
final authApiProvider = Provider((ref) {
  final account = ref.watch(accountProvider);
  return AuthApi(account: account);
});

//INTERFACE
abstract class IAuthApi {
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  });

  FutureEither<model.Session> login(
      {required String email, required String password});
  Future<model.Account?> getCurrentUser();
}

// MAIN CLASS
// AuthApi connect us to the appwrite with core functions, manin busines data
class AuthApi implements IAuthApi {
  final Account _account;
  AuthApi({required Account account}) : _account = account;

  @override
  Future<model.Account?> getCurrentUser()  async{
    try {
      return await _account.get();
    }on AppwriteException{
      return null;
    } 
    catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  }) async {
    try {
      model.Account account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } catch (e, stackTrace) {
      return left(Failrue(message: e.toString(), stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      model.Session session =
          await _account.createEmailSession(email: email, password: password);
      return right(session);
    } catch (e, stackTrace) {
      return left(Failrue(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
