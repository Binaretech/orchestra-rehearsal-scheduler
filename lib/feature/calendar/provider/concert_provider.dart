import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/data/repository/concert_repository.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/concert_reponse.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/concert_request.dart';
import 'package:orchestra_rehearsal_scheduler/providers/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'concert_provider.g.dart';

@riverpod
ConcertRepository concertRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return ConcertRepository(dio);
}

@riverpod
Future<CreateConcertResponse> createConcert(
    Ref ref, CreateConcertRequest concert) async {
  final repository = ref.read(concertRepositoryProvider);
  return repository.createConcert(concert);
}
