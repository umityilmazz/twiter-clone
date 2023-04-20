import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiter_clone_appwrite_io/apis/user_api.dart';
import 'package:twiter_clone_appwrite_io/features/auth/viewmodel/login_view_model.dart';
import 'package:twiter_clone_appwrite_io/features/home/view/home_view.dart';
import 'package:twiter_clone_appwrite_io/models/user_model.dart';
import '../../../apis/auth_api.dart';
import '../../../core/core.dart';

final authApiController = StateNotifierProvider<AuthApiController, bool>((ref) {
  final authApi = ref.watch(authApiProvider);
  final userApi = ref.watch(userApiProvider);

  return AuthApiController(authApi: authApi, userApi: userApi);
});

final currentUserProvider = FutureProvider((ref) async{
  var authApi = ref.watch(authApiController.notifier);
  return await authApi.currentUser();
});

class AuthApiController extends StateNotifier<bool> {
  final AuthApi _authApi;
  final UserApi _userApi;
  AuthApiController({required AuthApi authApi, required UserApi userApi})
      : _authApi = authApi,
        _userApi = userApi,
        super(false);

void signUp(
      {required String email,
      required String password,
      required BuildContext ctx}) async {
    state = true;
    final account = await _authApi.signUp(email: email, password: password);

    account.fold((l) => showSnackBar(ctx, l.message), (r) async {
      final user = UserModel(
          name: email.getName(),
          email: email,
          followers: [],
          following: [],
          bio: '',
          bannerPic: '',
          profilPic: '',
          uid: r.$id);
      final res = await _userApi.saveUser(user);
      state = false;
      res.fold((l) {
        showSnackBar(ctx, "SomeUnexpected error occured");
      }, (r) {
        showSnackBar(ctx, "Account is Created");
        Navigator.pushReplacement(ctx, LoginViewModel.route());
      });
    });
  }

void login(
      {required String email,
      required String password,
      required BuildContext ctx}) async {
    state = true;
    final session = await _authApi.login(email: email, password: password);
    state = false;
    session.fold(
        (l) => ScaffoldMessenger.of(ctx)
            .showSnackBar(SnackBar(content: Text(l.message))), (r) {
      Navigator.pushReplacement(ctx, HomeView.route());
    });
    state=false;
  }

Future<model.Account?> currentUser() => _authApi.getCurrentUser();
}
