import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingIndicatorProvider = NotifierProvider<LoadingIndicator, bool>(
  () => LoadingIndicator(),
);

class LoadingIndicator extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setLoading(bool value) {
    state = value;
  }
}
