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

import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';

import 'package:haneen_site__api_dashboard/features/teckstack/models/tech_stach_model.dart';

class ProjectModel {
  final int? id;
  final String slug;
  final String title;
  final String description;
  final String githubLink;
  final String iconUrl;
  final String price;
  final String liveDemoLink;
  final String thumbnailUrl;
  final List<String> features;
  final List<AppModel> relatedApplications;
  final List<TechStackModel> relatedTechStack;

  ProjectModel({
    this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.githubLink,
    required this.iconUrl,
    required this.price,
    required this.liveDemoLink,
    required this.thumbnailUrl,
    required this.features,
    required this.relatedApplications,
    required this.relatedTechStack,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      githubLink: json['githubLink'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
      price: json['price'] ?? '',
      liveDemoLink: json['liveDemoLink'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      features: json['features'] != null
          ? List<String>.from(json['features'].map((x) => x.toString()))
          : [],
      relatedApplications: json['relatedApplications'] != null
          ? List<AppModel>.from(
              json['relatedApplications'].map((x) => AppModel.fromJson(x)),
            )
          : [],
      relatedTechStack: json['relatedTechStack'] != null
          ? List<TechStackModel>.from(
              json['relatedTechStack'].map((x) => TechStackModel.fromJson(x)),
            )
          : [],
    );
  }

  ProjectModel copyWith({
    int? id,
    String? slug,
    String? title,
    String? description,
    String? githubLink,
    String? iconUrl,
    String? price,
    String? liveDemoLink,
    String? thumbnailUrl,
    List<String>? features,
    List<AppModel>? relatedApplications,
    List<TechStackModel>? relatedTechStack,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      description: description ?? this.description,
      githubLink: githubLink ?? this.githubLink,
      iconUrl: iconUrl ?? this.iconUrl,
      price: price ?? this.price,
      liveDemoLink: liveDemoLink ?? this.liveDemoLink,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      features: features ?? this.features,
      relatedApplications: relatedApplications ?? this.relatedApplications,
      relatedTechStack: relatedTechStack ?? this.relatedTechStack,
    );
  }

  Map<String, Object> toJson() {
    return {
      'id': id ?? 0,
      'slug': slug,
      'title': title,
      'description': description,
      'githubLink': githubLink,
      'iconUrl': iconUrl,
      'price': price,
      'liveDemoLink': liveDemoLink,
      'thumbnailUrl': thumbnailUrl,
      'features': List<dynamic>.from(features.map((x) => x)),
      'relatedApplications': List<dynamic>.from(
        relatedApplications.map((x) => x.toJson()),
      ),
      'relatedTechStack': List<dynamic>.from(
        relatedTechStack.map((x) => x.toJson()),
      ),
    };
  }
}
