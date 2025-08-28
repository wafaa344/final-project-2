class Company {
  final int id;
  final String name;
  final String? email;
  final String phone;
  final String location;
  final String logo;

  Company({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    required this.location,
    required this.logo,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      logo: json['logo'],
    );
  }
}

class ShowOrder {
  final int id;
  final String status;
  final int costOfExamination;
  final String location;
  final String budget;
  final String createdAt;
  final Company company;

  ShowOrder({
    required this.id,
    required this.status,
    required this.costOfExamination,
    required this.location,
    required this.budget,
    required this.createdAt,
    required this.company,
  });

  factory ShowOrder.fromJson(Map<String, dynamic> json) {
    return ShowOrder(
      id: json['id'],
      status: json['status'],
      costOfExamination: json['cost_of_examination'],
      location: json['location'],
      budget: json['budget'],
      createdAt: json['created_at'],
      company: Company.fromJson(json['company']),
    );
  }
}
