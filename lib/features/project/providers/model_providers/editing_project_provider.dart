import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';
import 'package:haneen_site__api_dashboard/features/project/models/project_model.dart';

import 'package:haneen_site__api_dashboard/features/teckstack/models/tech_stach_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/* 
 title: { type: DataTypes.STRING, allowNull: false },
  slug: { type: DataTypes.STRING, unique: true },
  description: DataTypes.TEXT,
  githubLink: DataTypes.STRING,
  iconUrl: DataTypes.STRING,
  price: DataTypes.STRING,
  liveDemoLink: DataTypes.STRING,
  features: DataTypes.ARRAY(DataTypes.STRING),

  thumbnailUrl: DataTypes.STRING,}

*/

class _EditingProjectNotifier extends Notifier<ProjectModel> {
  @override
  ProjectModel build() {
    return ProjectModel(
      id: 0,
      title: '',
      price: '',
      liveDemoLink: '',
      slug: '',
      description: '',
      githubLink: '',
      iconUrl: '',
      thumbnailUrl: '',
      relatedApplications: [],
      relatedTechStack: [],
      features: [],
    );
  }

  void setProject(ProjectModel project) {
    state = project;
  }

  void reset() {
    state = ProjectModel(
      id: 0,
      title: '',
      price: '',
      liveDemoLink: '',
      slug: '',
      description: '',
      githubLink: '',
      iconUrl: '',
      thumbnailUrl: '',
      relatedApplications: [],
      relatedTechStack: [],
      features: [],
    );
  }

  void editProject({
    int? id,

    String? price,
    String? liveDemoLink,
    String? slug,
    String? description,
    String? githubLink,
    String? iconUrl,
    String? thumbnailUrl,
    List<AppModel>? relatedApplications,
    List<TechStackModel>? relatedTechStack,
    List<String>? features,
  }) {
    state = ProjectModel(
      id: id ?? state.id,
      title: slug?.replaceAll('-', ' ') ?? state.title,
      price: price ?? state.price,
      liveDemoLink: liveDemoLink ?? state.liveDemoLink,
      slug: slug ?? state.slug,
      description: description ?? state.description,
      githubLink: githubLink ?? state.githubLink,
      iconUrl: iconUrl ?? state.iconUrl,
      thumbnailUrl: thumbnailUrl ?? state.thumbnailUrl,
      relatedApplications: relatedApplications ?? state.relatedApplications,
      relatedTechStack: relatedTechStack ?? state.relatedTechStack,
      features: features ?? state.features,
    );
  }
}

final editingProjectProvider =
    NotifierProvider<_EditingProjectNotifier, ProjectModel>(
      _EditingProjectNotifier.new,
    );
