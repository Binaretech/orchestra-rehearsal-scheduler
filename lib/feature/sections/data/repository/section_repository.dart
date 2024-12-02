import 'package:dio/dio.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/domain/section_musicians_response.dart';

class SectionRepository {
  final Dio dio;

  SectionRepository(this.dio);
  Future<SectionMusiciansResponse> getSectionMusicians(
    int id, {
    int page = 1,
    int perPage = 20,
    String? search,
    List<int> exclude = const [],
  }) async {
    final params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
      if (search != null) 'search': search,
      if (exclude.isNotEmpty) 'exclude': exclude.join(','),
    };

    final response =
        await dio.get('/sections/$id/musicians', queryParameters: params);

    if (response.statusCode == 200) {
      return SectionMusiciansResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load section musicians');
    }
  }
}
