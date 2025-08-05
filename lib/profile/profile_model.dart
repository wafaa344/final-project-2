class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? image;
  final int age;
  final String gender;
  final List<String> role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.age,
    required this.gender,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      age: json['age'],
      gender: json['gender'],
      role: List<String>.from(json['role']),
    );
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    int? age,
    String? gender,
    List<String>? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      role: role ?? this.role,
    );
  }
}
