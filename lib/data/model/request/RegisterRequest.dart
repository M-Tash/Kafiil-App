import 'dart:io';

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String about;
  final List<int> tags;
  final List<String> favoriteSocialMedia;
  final String salary;
  final String password;
  final String email;
  final String birthDate;
  final String? gender;
  final String type;
  final String passwordConfirmation;
  final File? avatar;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.about,
    required this.tags,
    required this.favoriteSocialMedia,
    required this.salary,
    required this.password,
    required this.email,
    required this.birthDate,
    this.gender,
    required this.type,
    required this.passwordConfirmation,
    this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'about': about,
      'tags': tags.join(','),
      'favorite_social_media': favoriteSocialMedia.join(','),
      'salary': salary,
      'password': password,
      'email': email,
      'birth_date': birthDate,
      'gender': gender,
      'type': type,
      'password_confirmation': passwordConfirmation,
      'avatar': avatar,
    };
  }
}
