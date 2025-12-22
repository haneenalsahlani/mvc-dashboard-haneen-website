import 'package:haneen_site__api_dashboard/core/models/related_tech_stack_model.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_feature_model.dart';

class AppModel {
  final String? id;
  final String title;
  final String description;
  final String icon;
  final String slug;
  final int? hoursWorked;
  final String? effortLevel;
  final double? price;
  final List<RelatedTechStackModel>? technologiesList;
  final List<AppFeatureModel> features;
  final String? githubLink;
  final String? liveLink;

  AppModel({
    this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.slug,
    this.hoursWorked,
    this.effortLevel,
    this.price,
    this.technologiesList,
    required this.features,
    this.githubLink,
    this.liveLink,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      id: json['id']?.toString(),
      title: (json['title'] as String?)?.trim() ?? '',
      description: (json['description'] as String?)?.trim() ?? '',
      icon: (json['icon'] as String?)?.trim() ?? '',
      slug: (json['slug'] as String?)?.trim() ?? '',
      hoursWorked: json['hoursWorked'] != null
          ? (json['hoursWorked'] is int
                ? json['hoursWorked']
                : int.tryParse(json['hoursWorked'].toString()))
          : null,
      effortLevel: json['effortLevel']?.toString().trim(),
      price: json['price'] != null
          ? (json['price'] is double
                ? json['price']
                : double.tryParse(json['price'].toString()))
          : null,
      technologiesList: json['technologiesList'] != null
          ? List<RelatedTechStackModel>.from(
              json['technologiesList'].map(
                (x) => RelatedTechStackModel.fromJson(x),
              ),
            )
          : null,
      features: json['features'] != null
          ? List<AppFeatureModel>.from(
              json['features'].map((x) => AppFeatureModel.fromJson(x)),
            )
          : [],
      githubLink: json['githubLink']?.toString().trim(),
      liveLink: json['liveLink']?.toString().trim(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
      'slug': slug,
      'hoursWorked': hoursWorked,
      'effortLevel': effortLevel,
      'price': price,
      'technologiesList': technologiesList != null
          ? List<dynamic>.from(technologiesList!.map((x) => x.toJson()))
          : null,
      'features': List<dynamic>.from(features.map((x) => x.toJson())),
      'githubLink': githubLink,
      'liveLink': liveLink,
    };
  }

  AppModel copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    String? slug,
    int? hoursWorked,
    String? effortLevel,
    double? price,
    List<RelatedTechStackModel>? technologiesList,
    List<AppFeatureModel>? features,
    String? githubLink,
    String? liveLink,
  }) {
    return AppModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,

      slug: slug ?? this.slug,
      hoursWorked: hoursWorked ?? this.hoursWorked,
      effortLevel: effortLevel ?? this.effortLevel,
      price: price ?? this.price,
      technologiesList: technologiesList ?? this.technologiesList,
      features: features ?? this.features,
      githubLink: githubLink ?? this.githubLink,
      liveLink: liveLink ?? this.liveLink,
    );
  }

  static AppModel intailValues() {
    return AppModel(
      title: '',
      description: '',
      icon: '',
      slug: '',
      features: [],
    );
  }
}
