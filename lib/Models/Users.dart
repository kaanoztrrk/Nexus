// ignore_for_file: file_names

class UserProfile {
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  late final String profileImage;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.profileImage,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      profileImage: '',
    );
  }
}
