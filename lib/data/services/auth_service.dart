import 'package:dio/dio.dart';
import 'api_client.dart';

class AuthService {
  final Dio _dio = ApiClient().dio;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/Auth/login',
        data: {'email': email, 'password': password},
      );
      return response.data;
    } catch (e) {
      throw Exception('Sai tài khoản hoặc mật khẩu');
    }
  }
}
