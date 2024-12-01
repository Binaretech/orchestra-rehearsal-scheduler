import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/data/repository/calendar_repository.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/families_response.dart';
import 'package:orchestra_rehearsal_scheduler/providers/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_provider.g.dart';

@riverpod
CalendarRepository calendarRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return CalendarRepository(dio);
}

@riverpod
Future<FamiliesResponse> getFamilies(Ref ref) async {
  final repository = ref.read(calendarRepositoryProvider);
  return repository.getFamilies();
}