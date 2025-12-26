import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/features/project/models/project_model.dart';

import 'package:haneen_site__api_dashboard/features/project/providers/model_providers/project_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _craeteProject extends AsyncNotifier<ProjectModel?> {
  @override
  ProjectModel? build() {
    return null;
  }

  Future<void> createProject() async {
    ProjectModel project = ref.read(ProjectProvider);
    project = project.copyWith(id: null);
    state = await AsyncValue.guard(() async {
      final dio = ref.read(dioProvider);
      final response = await dio.post(projectApiRoute, data: project.toJson());
      if (response.statusCode != 201) {
        throw Exception('Failed to create project');
      }

      final createdProject = ProjectModel.fromJson(response.data);
      return createdProject;
    });
  }

  Future<void> updateProject() async {
    ProjectModel project = ref.read(ProjectProvider);

    state = await AsyncValue.guard(() async {
      final dio = ref.read(dioProvider);
      final response = await dio.put(projectApiRoute, data: project.toJson());
      if (response.statusCode != 200) {
        throw Exception('Failed to update project');
      }

      final createdProject = ProjectModel.fromJson(response.data);
      return createdProject;
    });
  }
}

final createProjectProvider =
    AsyncNotifierProvider<_craeteProject, ProjectModel?>(_craeteProject.new);
