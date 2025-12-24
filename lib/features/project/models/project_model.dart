import 'package:haneen_site__api_dashboard/core/models/related_blogs_model.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';
import 'package:haneen_site__api_dashboard/features/teckstack/models/tech_stach_model.dart';

class ProjectModel {
  final int id;
  final String slug;
  final String name;
  final String description;
  final String githubLink;
  final String iconUrl;
  final String thumbnailUrl;

  final List<AppModel> relatedApplications;
  final List<TechStackModel> relatedTechStack;

  ProjectModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.githubLink,
    required this.iconUrl,
    required this.thumbnailUrl,
    required this.relatedApplications,
    required this.relatedTechStack,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      description: json['description'],
      githubLink: json['githubLink'],
      iconUrl: json['iconUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      relatedApplications: List<AppModel>.from(
        json['relatedApplications'].map((x) => AppModel.fromJson(x)),
      ),
      relatedTechStack: List<TechStackModel>.from(
        json['relatedTechStack'].map((x) => TechStackModel.fromJson(x)),
      ),
    );
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      'githubLink': githubLink,
      'iconUrl': iconUrl,
      'thumbnailUrl': thumbnailUrl,
      'relatedApplications': List<dynamic>.from(
        relatedApplications.map((x) => x.toJson()),
      ),
      'relatedTechStack': List<dynamic>.from(
        relatedTechStack.map((x) => x.toJson()),
      ),
    };
  }
}
