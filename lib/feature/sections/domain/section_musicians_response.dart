import 'package:orchestra_rehearsal_scheduler/feature/users/data/model/user.dart';

class SectionMusiciansResponse {
  final List<User> data;
  final int total;

  SectionMusiciansResponse({required this.data, required this.total});

  factory SectionMusiciansResponse.fromJson(Map<String, dynamic> json) {
    return SectionMusiciansResponse(
      data: (json['data'] as List).map((e) => User.fromJson(e)).toList(),
      total: json['total'],
    );
  }
}
