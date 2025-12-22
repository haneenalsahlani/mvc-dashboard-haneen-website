class AppFeatureModel {
  final String title;
  final String description;
  final String imageUrl;

  AppFeatureModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory AppFeatureModel.fromJson(Map<String, dynamic> json) {
    return AppFeatureModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  AppFeatureModel copyWith({
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return AppFeatureModel(
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'imageUrl': imageUrl};
  }
}
