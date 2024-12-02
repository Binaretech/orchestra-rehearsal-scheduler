import 'package:orchestra_rehearsal_scheduler/feature/sections/data/model/section.dart';

class Family {
  int id;
  String name;
  List<Section> sections;

  Family({
    required this.id,
    required this.name,
    required this.sections,
  });

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
      id: json['id'],
      name: json['name'],
      sections: List<Section>.from(
        json['sections'].map((section) => Section.fromJson(section)),
      ),
    );
  }
}
