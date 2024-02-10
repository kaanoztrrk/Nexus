class User {
  final String firstName;
  final String lastName;
  final int age;
  final String gender;

  User({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
  });

  // JSON'dan User nesnesi oluştur
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
    );
  }

  // User nesnesini JSON'a dönüştür
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
    };
  }
}
