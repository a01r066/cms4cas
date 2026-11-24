import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'app_config.dart';
import 'core/data/firestore_record_store.dart';
import 'core/data/local_record_store.dart';
import 'core/data/record_store.dart';
import 'firebase_options.dart';
import 'shared/providers.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  RecordStore store;
  if (kUseFirebase) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    store = FirestoreRecordStore(FirebaseFirestore.instance, kCasinoId);
  } else {
    store = LocalRecordStore(prefs);
  }
  runApp(ProviderScope(
    overrides: [
      prefsProvider.overrideWithValue(prefs),
      recordStoreProvider.overrideWithValue(store),
    ],
    child: const CmsApp(),
  ));
}
