class RelatedTechStackModel {
  final int id;
  final String name;
  final String iconUrl;
  final String createdAt;
  final String updatedAt;

  RelatedTechStackModel({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RelatedTechStackModel.fromJson(Map<String, dynamic> json) {
    return RelatedTechStackModel(
      id: json['id'],
      name: json['name'],
      iconUrl: json['iconUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconurl': iconUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
