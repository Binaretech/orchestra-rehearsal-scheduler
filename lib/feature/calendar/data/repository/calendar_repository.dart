import 'package:dio/dio.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/families_response.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/calendar_response.dart';

class CalendarRepository {
  final Dio dio;

  CalendarRepository(this.dio);

  Future<FamiliesResponse> getFamilies() async {
    final response = await dio.get('/families');
    if (response.statusCode == 200) {
      return FamiliesResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load families');
    }
  }

  Future<CalendarResponse> getEntries({int? month, int? year}) async {
    final response = await dio.get('/calendar', queryParameters: {
      if (month != null) 'month': month,
      if (year != null) 'year': year,
    });
    if (response.statusCode == 200) {
      return CalendarResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load entries');
    }
  }
}
