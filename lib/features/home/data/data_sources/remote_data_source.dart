import 'package:dio/dio.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/core/response_data.dart';

abstract class HomeRemoteDataSource {
  Future<ResponseData> getProfile();

  Future<ResponseData> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;
  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<ResponseData> getProfile() async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.get('$baseUrl/profile');
    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.data);
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }

  @override
  Future<ResponseData> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.post(
      '$baseUrl/update-password',
      data: {'old_password': oldPassword, 'new_password': newPassword},
    );
    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.data);
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }
}
