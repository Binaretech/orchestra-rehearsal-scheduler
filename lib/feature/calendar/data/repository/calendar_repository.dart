import 'package:dio/dio.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/families_response.dart';

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
}
