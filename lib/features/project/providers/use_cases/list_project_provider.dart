import 'dart:async';

import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/features/project/models/project_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListProjectNotifier extends AsyncNotifier<List<ProjectModel>?> {
  // Replace with your actual API endpoint

  @override
  Future<List<ProjectModel>?> build() async {
    // Just return the Future directly - framework handles AsyncValue wrapping
    final response = await ref.read(dioProvider).get(projectApiRoute);

    // Parse the JSON response to List<ProjectModel>
    final List<dynamic> jsonList = response.data as List<dynamic>;

    return jsonList
        .map((json) => ProjectModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Optional: Add a refresh method to reload data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(dioProvider).get(projectApiRoute);
      final List<dynamic> jsonList = response.data as List<dynamic>;
      return jsonList
          .map((json) => ProjectModel.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }
}

// Provider definition
final listProjectNotifierProvider =
    AsyncNotifierProvider<ListProjectNotifier, List<ProjectModel>?>(
      () => ListProjectNotifier(),
    );
