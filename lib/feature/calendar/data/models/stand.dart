import 'package:orchestra_rehearsal_scheduler/feature/users/data/model/user.dart';

class Stand {
  final int id;
  final int standNumber;
  final int concertSectionId;
  final List<User> users;

  Stand({
    required this.id,
    required this.standNumber,
    required this.concertSectionId,
    required this.users,
  });

  factory Stand.fromJson(Map<String, dynamic> json) {
    return Stand(
      id: json['id'],
      standNumber: json['standNumber'],
      concertSectionId: json['concertSectionId'],
      users: (json['users'] as List).map((i) => User.fromJson(i)).toList(),
    );
  }
}
