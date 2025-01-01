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

  String get offset {
    final date = DateTime.now();

    final offsetHours = date.timeZoneOffset.inHours;
    final offsetMinutes = date.timeZoneOffset.inMinutes % 60;
    final offsetString =
        '${offsetHours.toString().padLeft(2, '0')}:${offsetMinutes.toString().padLeft(2, '0')}';

    return offsetString;
  }

  Future<CalendarResponse> getEntries({int? month, int? year, int? day}) async {
    final response = await dio.get('/calendar', queryParameters: {
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (day != null) 'day': day,
      'offset': offset,
    });

    if (response.statusCode == 200) {
      return CalendarResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load entries');
    }
  }

  Future<CalendarDateResponse> getDateEntries(
      {int? day, int? month, int? year}) async {
    final response = await dio.get('/calendar/date', queryParameters: {
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (day != null) 'day': day,
      'offset': offset,
    });

    if (response.statusCode == 200) {
      return CalendarDateResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load entries');
    }
  }
}
