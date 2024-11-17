import 'package:orchestra_rehearsal_scheduler/feature/auth/data/model/profile.dart';

class User {
  final int id;
  final String email;
  final String role;
  final Profile profile;
  final String createdAt;
  final String updatedAt;

  User(
      {required this.id,
      required this.email,
      required this.role,
      required this.profile,
      required this.createdAt,
      required this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        role: json['role'],
        profile: Profile.fromJson(json['profile']),
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
