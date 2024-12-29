import 'package:orchestra_rehearsal_scheduler/feature/calendar/data/models/concert_section.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/data/models/rehearshal.dart';

class Concert {
  final int id;
  final String title;
  final DateTime concertDate;
  final String concertDateStatus;
  final String location;
  final String description;
  final List<Rehearsal> rehearsals;
  final List<ConcertSection> sections;
  final DateTime createdAt;
  final DateTime updatedAt;

  Concert({
    required this.id,
    required this.title,
    required this.concertDate,
    required this.concertDateStatus,
    required this.location,
    required this.description,
    required this.rehearsals,
    required this.sections,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Concert.fromJson(Map<String, dynamic> json) {
    return Concert(
      id: json['id'],
      title: json['title'],
      concertDate: DateTime.parse(json['concertDate']),
      concertDateStatus: json['concertDateStatus'],
      location: json['location'],
      description: json['description'],
      rehearsals: (json['rehearsals'] as List)
          .map((i) => Rehearsal.fromJson(i))
          .toList(),
      sections: (json['sections'] as List)
          .map((i) => ConcertSection.fromJson(i))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
