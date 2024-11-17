import 'package:orchestra_rehearsal_scheduler/feature/auth/data/model/user.dart';

class LoginResponse {
  final User user;
  final String accessToken;

  LoginResponse({required this.user, required this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        user: User.fromJson(json['user']), accessToken: json['accessToken']);
  }
}
