class PreviousProjectsModel {
  final int id;
  final String projectName;
  final String status;
  final String startDate;
  final String endDate;
  final int finalCost;
  final String description;
  final List<ProjectImage> projectImages;
  final int? rate;
  final String? comment;

  PreviousProjectsModel({
    required this.id,
    required this.projectName,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.description,
    required this.finalCost,
    required this.projectImages,
    this.rate,
    this.comment,
  });

  factory PreviousProjectsModel.fromJson(Map<String, dynamic> json) {
    return PreviousProjectsModel(
      id: json['id'],
      projectName: json['project_name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      status: json['status'],
      description: json['description'],
      finalCost: json['final_cost'],
      rate: json['customer_rating'],
      comment: json['customer_comment'],
      projectImages: (json['images'] as List)
          .map((img) => ProjectImage.fromJson(img))
          .toList(),
    );
  }
}

class ProjectImage {
  final int id;
  final int projectId;
  final String beforeImage;
  final String afterImage;
  final String caption;
  final String createdAt;
  final String updatedAt;

  ProjectImage({
    required this.id,
    required this.projectId,
    required this.beforeImage,
    required this.afterImage,
    required this.caption,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectImage.fromJson(Map<String, dynamic> json) {
    return ProjectImage(
      id: json['id'],
      projectId: json['project_id'],
      beforeImage: json['before_image'],
      afterImage: json['after_image'],
      caption: json['caption'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
