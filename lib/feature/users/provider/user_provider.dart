import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/users/data/repository/user_repository.dart';
import 'package:orchestra_rehearsal_scheduler/providers/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return UserRepository(dio);
}
