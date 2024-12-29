import 'package:orchestra_rehearsal_scheduler/feature/calendar/data/models/concert.dart';

class CreateConcertResponse {
  final Concert data;

  CreateConcertResponse({required this.data});

  factory CreateConcertResponse.fromJson(Map<String, dynamic> json) {
    return CreateConcertResponse(
      data: Concert.fromJson(json['data']),
    );
  }
}
