import 'package:orchestra_rehearsal_scheduler/feature/auth/data/model/profile.dart';

class User {
  final int id;
  final String email;
  final String role;
  final Profile profile;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.role,
    required this.profile,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      profile: Profile.fromJson(json['profile']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  String get fullname => '${profile.firstName} ${profile.lastName}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
