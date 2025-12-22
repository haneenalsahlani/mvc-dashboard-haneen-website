import 'package:flutter_riverpod/flutter_riverpod.dart';

final blogSlugProvider = NotifierProvider<blogSlug, String>(() {
  return blogSlug();
});

class blogSlug extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void addValue(String newValue) {
    state = newValue;
  }

  void clear() {
    state = "";
  }
}
