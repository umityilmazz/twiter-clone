import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/appwrite_constant.dart';

        // Appwriteio Dependecys

// CLIENT
final clientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppWriteConstant.endPoint)
      .setProject(AppWriteConstant.projectId);
});
// ACCOUNT
final accountProvider = Provider((ref) => Account(ref.watch(clientProvider)));
//DATABESE
final databeseProvider = Provider((ref) {
  final db = Databases(ref.watch(clientProvider));
  return db;
});
// STORAGE
final storageProvider = Provider((ref) {
  return Storage(ref.watch(clientProvider));
});
// REALTIME
final realtimeProvider = Provider((ref) {
  final client = ref.watch(clientProvider);
  return Realtime(client);
});
