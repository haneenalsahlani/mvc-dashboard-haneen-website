import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

///////////
class ContentInputControllerNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void addText(String value) {
    state = value;
  }

  clear() {
    state = "";
  }
}

// ✅ U😘😘😘👌se 'final' instead of 'var' for providers
final contentInputControllerProvider =
    NotifierProvider<ContentInputControllerNotifier, String>(() {
      return ContentInputControllerNotifier();
    });
