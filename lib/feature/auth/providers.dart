import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/auth/data/repository/auth_repository.dart';
import 'package:orchestra_rehearsal_scheduler/providers/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return AuthRepository(dio);
}

@riverpod
class Auth extends _$Auth {
  @override
  bool build() => false;

  Future<bool> login(String email, String password) async {
    final repository = ref.read(authRepositoryProvider);
    final response = await repository.login(email, password);

    state = response;

    return response;
  }

  Future<bool> logout() async {
    return false;
  }
}
