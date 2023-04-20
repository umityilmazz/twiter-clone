import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiter_clone_appwrite_io/common/error_page.dart';
import 'package:twiter_clone_appwrite_io/common/loading_page.dart';
import 'package:twiter_clone_appwrite_io/features/auth/controller/auth_controller.dart';
import 'package:twiter_clone_appwrite_io/features/auth/view/login_view.dart';
import 'package:twiter_clone_appwrite_io/features/home/view/home_view.dart';
import 'package:twiter_clone_appwrite_io/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: AppTheme.theme,
      home: ref.watch(currentUserProvider).when(
            data: (data) {
              if (data != null) {
                return const  HomeView();
              } else {
                return const LoginView();
              }
            },
            error: (error, stackTrace) {
              const ErrorPage();
            },
            loading: () => const LoadingPage(),
          ),
    );
  }
}


/*
1-uodateretweet count
2-retwetedby parametresi


 */