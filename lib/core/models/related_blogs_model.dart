class RelatedBlogsModel {
  final int id;
  final String title;
  final String slug;
  final String summary;

  final String createdAt;
  final String updatedAt;

  RelatedBlogsModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.summary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RelatedBlogsModel.fromJson(Map<String, dynamic> json) {
    return RelatedBlogsModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      summary: json['summary'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'summary': summary,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
