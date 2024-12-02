import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/families_response.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/data/repository/family_repository.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/data/repository/section_repository.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/domain/section_musicians_response.dart';
import 'package:orchestra_rehearsal_scheduler/providers/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sections_provider.g.dart';

@riverpod
FamilyRepository familyRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return FamilyRepository(dio);
}

@riverpod
SectionRepository sectionRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return SectionRepository(dio);
}

@riverpod
Future<FamiliesResponse> getFamilies(Ref ref) async {
  final repository = ref.read(familyRepositoryProvider);
  return repository.getFamilies();
}

@riverpod
class GetSectionMusicians extends _$GetSectionMusicians {
  @override
  Future<SectionMusiciansResponse> build(int id,
      {int page = 1,
      int perPage = 20,
      String? search,
      List<int> exclude = const []}) async {
    final repository = ref.read(sectionRepositoryProvider);

    try {
      final response = await repository.getSectionMusicians(
        id,
        page: page,
        perPage: perPage,
        search: search,
        exclude: exclude,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
