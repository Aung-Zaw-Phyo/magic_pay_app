import 'package:dio/dio.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/auth/data/models/user.dart';

abstract class AuthRemoteDataSource {
  Future<String> register(UserModel user);

  Future<String> login({required String phone, required String password});

  Future<Null> logout();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<String> login(
      {required String phone, required String password}) async {
    final response = await _dio
        .post('$baseUrl/login', data: {"phone": phone, "password": password});

    if (response.statusCode == 200) {
      return response.data['data']['token'];
    } else {
      throw ServerException(response.data['message'] ?? 'Something worng');
    }
  }

  @override
  Future<Null> logout() async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.post('$baseUrl/logout');
    if (response.statusCode == 200) {
      return null;
    } else {
      throw ServerException(response.data['message'] ?? 'Something worng');
    }
  }

  @override
  Future<String> register(UserModel user) async {
    final response = await _dio.post('$baseUrl/register', data: user.toJson());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['data']['token'];
    } else {
      throw ServerException(response.data['message'] ?? 'Something worng');
    }
  }
}
