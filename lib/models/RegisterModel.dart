class User {
  final String name;
  final String email;
  final String password;
  final String address;
  final String dob;
  final String phone;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.dob,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'dob': dob,
      'phone': phone,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      dob: json['dob'],
      phone: json['phone'],
    );
  }
}
