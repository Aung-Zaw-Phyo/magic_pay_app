import 'package:dio/dio.dart';
import 'package:magic_pay_app/core/constants/constants.dart';

final Dio dio_client = Dio(BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 15),
  headers: {
    "Content-Type": "application/json",
    'Accept': 'application/json',
  },
  validateStatus: (status) => status! <= 500,
));
