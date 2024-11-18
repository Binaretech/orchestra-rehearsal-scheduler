import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/auth/data/repository/auth_repository.dart';
import 'package:orchestra_rehearsal_scheduler/providers/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return AuthRepository(dio);
}

@riverpod
Future<bool> initializeAuth(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();

  final accessToken = prefs.getString("accessToken");

  final provider = ref.read(authProvider.notifier);

  final result = accessToken != null && accessToken.isNotEmpty;

  provider.setAuth(result);

  return result;
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  bool build() => false;

  @override
  bool updateShouldNotify(bool previous, bool next) {
    return true;
  }

  Future<bool> login(String email, String password) async {
    final repository = ref.read(authRepositoryProvider);
    await repository.login(email, password);

    state = true;

    return true;
  }

  void setAuth(bool value) {
    state = value;
  }

  Future<bool> logout() async {
    return false;
  }
}
