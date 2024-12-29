import 'package:orchestra_rehearsal_scheduler/feature/calendar/data/models/stand.dart';

class ConcertSection {
  final int id;
  final int concertId;
  final int sectionId;
  final List<Stand> stands;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConcertSection({
    required this.id,
    required this.concertId,
    required this.sectionId,
    required this.stands,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConcertSection.fromJson(Map<String, dynamic> json) {
    return ConcertSection(
      id: json['id'],
      concertId: json['concertId'],
      sectionId: json['sectionId'],
      stands: (json['stands'] as List).map((i) => Stand.fromJson(i)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
