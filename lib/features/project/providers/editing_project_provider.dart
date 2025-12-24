import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';
import 'package:haneen_site__api_dashboard/features/project/models/project_model.dart';
import 'package:haneen_site__api_dashboard/features/teckstack/models/tech_stach_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _EditingProjectNotifier extends Notifier<ProjectModel> {
  @override
  ProjectModel build() {
    return ProjectModel(
      id: 0,
      name: '',
      slug: '',
      description: '',
      githubLink: '',
      iconUrl: '',
      thumbnailUrl: '',
      relatedApplications: [],
      relatedTechStack: [],
    );
  }

  void editProject({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? githubLink,
    String? iconUrl,
    String? thumbnailUrl,
    List<AppModel>? relatedApplications,
    List<TechStackModel>? relatedTechStack,
  }) {
    state = ProjectModel(
      id: id ?? state.id,
      name: name ?? state.name,
      slug: slug ?? state.slug,
      description: description ?? state.description,
      githubLink: githubLink ?? state.githubLink,
      iconUrl: iconUrl ?? state.iconUrl,
      thumbnailUrl: thumbnailUrl ?? state.thumbnailUrl,
      relatedApplications: relatedApplications ?? state.relatedApplications,
      relatedTechStack: relatedTechStack ?? state.relatedTechStack,
    );
  }
}

final editingProjectProvider =
    NotifierProvider<_EditingProjectNotifier, ProjectModel>(
      _EditingProjectNotifier.new,
    );
