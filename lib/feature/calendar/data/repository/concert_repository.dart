import 'package:dio/dio.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/concert_reponse.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/concert_request.dart';

class ConcertRepository {
  final Dio dio;

  ConcertRepository(this.dio);

  Future<CreateConcertResponse> createConcert(CreateConcertRequest data) async {
    final response = await dio.post('/concerts', data: data.toJson());

    final status = response.statusCode ?? 0;

    if (status >= 200 && status < 300) {
      return CreateConcertResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to create concerttttt');
    }
  }
}
