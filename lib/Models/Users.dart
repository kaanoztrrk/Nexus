class UserProfile {
  final String email;
  final String firstName;
  final String lastName;
  final String age;
  final String gender;

  UserProfile({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
  });

  // fromMap fonksiyonu ile Firestore'dan gelen verileri UserProfile nesnesine dönüştürür
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age'] ?? "", // Firestore'dan gelen yaş verisi integer olmalı
      gender: map['gender'] ?? '',
    );
  }
}
