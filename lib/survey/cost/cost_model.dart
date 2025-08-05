// cost_model.dart

class AnswerModel {
  final int questionId;
  final String answer;

  AnswerModel({required this.questionId, required this.answer});

  Map<String, dynamic> toJson() => {
    'question_id': questionId,
    'answer': answer,
  };
}

class ServiceAnswers {
  final int serviceId;
  final List<AnswerModel> answers;

  ServiceAnswers({required this.serviceId, required this.answers});

  Map<String, dynamic> toJson() => {
    'service_id': serviceId,
    'answers': answers.map((a) => a.toJson()).toList(),
  };
}

class CostRequest {
  final List<ServiceAnswers> services;

  CostRequest({required this.services});

  Map<String, dynamic> toJson() => {
    'services': services.map((s) => s.toJson()).toList(),
  };
}

class CostResponse {
  final bool status;
  final double totalPrice;

  CostResponse({required this.status, required this.totalPrice});

  factory CostResponse.fromJson(Map<String, dynamic> json) {
    return CostResponse(
      status: json['status'],
      totalPrice: double.parse(json['total_price'].toString()),
    );
  }
}
