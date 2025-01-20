class User {
  final int id;
  final String name;
  final String email;
  final String address;
  final String dob;
  final String phone;
  final String? gender;
  final DateTime? emailVerifiedAt;
  final String? rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.dob,
    required this.phone,
    this.gender,
    this.emailVerifiedAt,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      dob: json['dob'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String?,
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'] as String)
          : null,
      rememberToken: json['remember_token'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'dob': dob,
      'phone': phone,
      'gender': gender,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'remember_token': rememberToken,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
