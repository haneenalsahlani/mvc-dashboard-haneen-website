/*

 name: { type: DataTypes.STRING, allowNull: false, unique: true },
  slug: { type: DataTypes.STRING, allowNull: false, unique: true },
  iconUrl: DataTypes.STRING,
  proficiencyLevel: DataTypes.INTEGER,
  description: DataTypes.TEXT,
coursesLink: DataTypes.STRING,

*/

class TechStackModel {
  String name;
  String slug;
  String iconUrl;
  int proficiencyLevel;
  String description;
  String coursesLink;

  TechStackModel({
    required this.name,
    required this.slug,
    required this.iconUrl,
    required this.proficiencyLevel,
    required this.description,
    required this.coursesLink,
  });

  factory TechStackModel.fromJson(Map<String, dynamic> json) {
    return TechStackModel(
      name: json['name'],
      slug: json['slug'],
      iconUrl: json['iconUrl'],
      proficiencyLevel: json['proficiencyLevel'],
      description: json['description'],
      coursesLink: json['coursesLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'iconUrl': iconUrl,
      'proficiencyLevel': proficiencyLevel,
      'description': description,
      'coursesLink': coursesLink,
    };
  }

  factory TechStackModel.intailValues() {
    return TechStackModel(
      name: '',
      slug: '',
      iconUrl: '',
      proficiencyLevel: 0,
      description: '',
      coursesLink: '',
    );
  }

  TechStackModel copyWith({
    required String name,
    required String slug,
    required String iconUrl,
    required int proficiencyLevel,
    required String description,
    required String coursesLink,
  }) {
    return TechStackModel(
      name: name,
      slug: slug,
      iconUrl: iconUrl,
      proficiencyLevel: proficiencyLevel,
      description: description,
      coursesLink: coursesLink,
    );
  }
}
