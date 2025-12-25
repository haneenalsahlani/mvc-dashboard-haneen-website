import 'package:hooks_riverpod/hooks_riverpod.dart';

class _selectedProjectNotifier extends Notifier<String> {
  @override
  String build() {
    // TODO: implement build
    return "";
  }

  void setSelectedProject(String project) {
    state = project;
  }

  void resetSelectedProject() {
    state = "";
  }
}

final selectedProjectProvider =
    NotifierProvider<_selectedProjectNotifier, String>(
      () => _selectedProjectNotifier(),
    );
