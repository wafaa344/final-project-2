// survey_model.dart
class OptionModel {
  final int id;
  final String name;
  final String unit;
  final String price;

  OptionModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      name: json['name'],
      unit: json['unit'],
      price: json['price'],
    );
  }
}

class QuestionModel {
  final int id;
  final String question;
  final bool hasOptions;
  final List<OptionModel> options;

  QuestionModel({
    required this.id,
    required this.question,
    required this.hasOptions,
    required this.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      question: json['question'],
      hasOptions: json['has_options'],
      options: json['options'] != null
          ? List<OptionModel>.from(
          json['options'].map((x) => OptionModel.fromJson(x)))
          : [],
    );
  }
}

class ServiceModel {
  final int id;
  final String name;
  final List<QuestionModel> questions;

  ServiceModel({
    required this.id,
    required this.name,
    required this.questions,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      questions: List<QuestionModel>.from(
        json['questions'].map((x) => QuestionModel.fromJson(x)),
      ),
    );
  }
}
