import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/features/project/models/project_model.dart';

class _checkSlugExists extends AsyncNotifier<ProjectModel?> {
  @override
  FutureOr<ProjectModel?> build() {
    return null;
  }

  Future<void> checkSlugExists(String slug) async {
    slug = slug.trim().replaceAll(' ', '-');

    state = await AsyncValue.guard(() async {
      final dio = ref.read(dioProvider);
      final response = await dio.get("$projectApiRoute/$slug");
      print(projectApiRoute + "/" + slug);
      print(response.data);

      final result = ProjectModel.fromJson(response.data);

      return result;
    });
  }
}

final checkProjectSlugExistsProvider =
    AsyncNotifierProvider<_checkSlugExists, ProjectModel?>(
      _checkSlugExists.new,
    );
