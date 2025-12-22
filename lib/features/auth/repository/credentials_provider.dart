import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/////// shouldbe username:password
final credentialsProvider =
    AsyncNotifierProvider<LogInCredentialsNotifier, String>(() {
      return LogInCredentialsNotifier();
    });

// Now your notifier can be synchronous
class LogInCredentialsNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("info") ?? "";
  }

  Future<void> updateCredentials(String newCredentials) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("info", newCredentials);

    state = AsyncData(newCredentials);
  }

  Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("info", "");
    state = const AsyncData("");
  }
}
