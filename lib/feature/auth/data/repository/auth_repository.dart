import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['accessToken'];

        final sharePrefs = await SharedPreferences.getInstance();

        await sharePrefs.setString('accessToken', accessToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.remove('accessToken');
  }
}
