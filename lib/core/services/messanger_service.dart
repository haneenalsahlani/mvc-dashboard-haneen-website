import 'package:flutter/material.dart';

class MessengerService {
  static final MessengerService _instance = MessengerService._internal();
  factory MessengerService() => _instance;
  MessengerService._internal();

  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showError(String message) {
    // Add a small delay to ensure the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () {
              messengerKey.currentState?.hideCurrentSnackBar();
            },
          ),
        ),
      );
    });
  }

  void showSuccess(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  void showInfo(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.blue,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }
}
