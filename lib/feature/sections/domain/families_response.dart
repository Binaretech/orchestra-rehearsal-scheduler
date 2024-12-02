import 'package:orchestra_rehearsal_scheduler/feature/sections/data/model/family.dart';

class FamiliesResponse {
  final List<Family> families;

  FamiliesResponse({required this.families});

  factory FamiliesResponse.fromJson(List<dynamic> json) {
    final families = json.map((family) => Family.fromJson(family)).toList();

    return FamiliesResponse(families: families);
  }
}
