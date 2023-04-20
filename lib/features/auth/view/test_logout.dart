import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiter_clone_appwrite_io/core/appwriteio_providers.dart';

class LogOutView extends ConsumerWidget {
  const LogOutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Account account = ref.watch(accountProvider);
            await account.deleteSession(sessionId: 'current');
          },
          child: Text("Log Out"),
        ),
      ),
    );
  }
}
