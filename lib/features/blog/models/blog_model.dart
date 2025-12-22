class BlogModel {
  final String title;
  final String? slug;
  final int? id;
  final String content;
  final String summary;

  BlogModel({
    required this.title,
    this.slug,
    this.id,
    required this.content,
    required this.summary,
  });

  factory BlogModel.intailValue() {
    return BlogModel(id: 0, slug: "", title: "", content: "", summary: "");
  }
  BlogModel copyWith({
    String? title,
    String? slug,
    int? id,
    String? content,
    String? summary,
  }) {
    return BlogModel(
      title: title ?? this.title,
      slug: slug ?? this.slug,
      id: id ?? this.id,
      content: content ?? this.content,
      summary: summary ?? this.summary,
    );
  }

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as int,
      slug: json['slug'],
      title: json['title'],
      content: json['content'],
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'slug': slug,
      'id': id,
      'content': content,
      'summary': summary,
    };
  }
}
