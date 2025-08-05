class ProjectImage {
  final int id;
  final String beforeImage;
  final String afterImage;
  final String caption;

  ProjectImage({
    required this.id,
    required this.beforeImage,
    required this.afterImage,
    required this.caption,
  });

  factory ProjectImage.fromJson(Map<String, dynamic> json) {
    return ProjectImage(
      id: json['id'],
      beforeImage: json['before_image'],
      afterImage: json['after_image'],
      caption: json['caption'],
    );
  }
}

class Project {
  final int id;
  final String companyName;
  final String projectName;
  // final int rating;

  Project({
    required this.id,
    required this.companyName,
    required this.projectName,
    // required this.rating,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      companyName: json['company_name'],
      projectName: json['project_name'],
      // rating: json['rating'],
    );
  }
}
